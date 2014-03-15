module SalsaLabs
  ##
  # Base class used for subclasses that can be represented by Salsa Labs
  # concepts that can be returned by getObject or getObjects.
  ##
  class SalsaObject

    attr_reader :attributes

    def initialize(params)
      @attributes = params
    end

    def organization_key
      (attributes['organization_key'] || 0).to_i
    end

    #TODO, make these singletons?
    def save(credentials = {})
      if not @saver
        @saver = SalsaObjectsSaver.new(credentials)
      end
      @saver.save(self.attributes)
    end

    def tag(tag)
      if not @saver
        @saver = SalsaObjectsSaver.new(credentials)
      end

      @saver.tag(self,tag)
    end

  end
end
