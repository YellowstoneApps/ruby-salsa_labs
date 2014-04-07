module SalsaLabs
  ##
  # Base class used for subclasses that can be represented by Salsa Labs
  # concepts that can be returned by getObject or getObjects.
  ##
  class SalsaObject

    attr_reader :attributes

    def initialize(params)
      params.stringify_keys!
      @attributes = params
    end

    def organization_key
      (attributes['organization_key'] || 0).to_i
    end

    def object_name
      self.class.name.split('::').last.downcase
    end

    def object_key
      object_name+'_key'
    end

    def save(credentials = {})
      new_id = saver(credentials).save(self.attributes.update({'object'=>object_name}))
      self.attributes.update({'key'=>new_id})
    end

    def tag(tag, credentials = {})
      params = {'object'=>object_name,
                'key'=>self.attributes['key'],
                'tag'=>tag}
      saver(credentials).save(params)
    end

    def saver(credentials)
      @saver ||= SalsaObjectsSaver.new(credentials)
    end

    def self.integer_attributes(*methods)
      methods.each do |method|
        define_method(method) do
          (attributes[method.to_s] || 0).to_i
        end
      end
    end

    def self.string_attributes(*methods)
      methods.each do |method|
        define_method(method) do
          attributes[method.to_s]
        end
      end
    end

    def self.boolean_attributes(*methods)
      methods.each do |method|
        define_method(method) do
          (attributes[method.to_s] == '1') || (attributes[method.to_s] == 1)
        end
      end
    end

  end
end
