module SalsaLabs
  ##
  # Service object to pull back a collection of objects from the Salsa Labs API.
  ##
  class SalsaObjectsFetcher

    def initialize(filter_parameters = {}, credentials = {})
      @filter_parameters = SalsaLabs::ApiObjectParameterList.new(filter_parameters)
      @client = SalsaLabs::ApiClient.new(credentials)
    end

    def fetch
      item_objects(get_objects)
    end

    def tagged
      item_objects(get_tagged_objects)
    end

    private

    attr_reader :client, :filter_parameters

    def get_objects
      client.fetch('/api/getObjects.sjs', api_parameters)
      #Note, this will return at most 500 records
      #TODO, implement pagination
    end

    def get_tagged_objects
      client.fetch('/api/getTaggedObjects.sjs', api_parameters)
    end

    def api_parameters
      if filter_parameters
        params = {'condition'=>filter_parameters.attributes.flat_map {|k,v| "#{k}=#{v}" }}
      else
        params = {} 
      end

      params.merge(object: @object_class.name.split('::').last.downcase)
    end

    def item_objects(url)
      item_nodes(url).map do |node|
        @object_class.new(ApiObjectNode.new(node).attributes)
      end
    end

    def item_nodes(url)
      Nokogiri::XML(url).css('item')
    end

    ##
    # Object used to translate API's XML node into a hash of attributes for
    # SalsaLabs::Object creation.
    ##
    class ApiObjectNode

      def initialize(xml_element)
        @node = xml_element
      end

      def attributes
        children.inject({}) do |memo, attribute|
          memo[attribute.name.downcase] = attribute.text
          memo
        end
      end

      private

      attr_reader :node

      def children
        node.children
      end

    end
  end
end
