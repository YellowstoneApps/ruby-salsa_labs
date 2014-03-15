module SalsaLabs
  ##
  # Service object to pull back a collection of objects from the Salsa Labs API.
  ##
  class SalsaObjectsFetcher

    def initialize(filter_parameters = {}, credentials = {})
      @filter_parameters = filter_parameters
      @client = SalsaLabs::ApiClient.new(credentials)
    end

    def fetch
      # override this in child classes
      # create SalsaLabs:: objects with SalsaLabsApiObjectNode.new(node).attributes
      item_nodes
    end

    private

    attr_reader :client, :filter_parameters

    def api_call
      client.fetch('/api/getObjects.sjs', api_parameters)
    end

    def api_parameters
      # override in child classes
      filter_parameters
    end

    def item_nodes
      Nokogiri::XML(api_call).css('item')
    end

    ##
    # Object used to translate API's XML node into a hash of attributes for
    # SalsaLabs::Object creation.
    ##
    class SalsaLabsApiObjectNode

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
