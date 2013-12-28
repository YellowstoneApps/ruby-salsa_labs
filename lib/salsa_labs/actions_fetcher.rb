module SalsaLabs
  ##
  # Service object to pull back a collection of actions from the Salsa Labs API.
  ##
  class ActionsFetcher

    def initialize(filter_parameters = {}, credentials = {})
      @filter_parameters = filter_parameters
      @client = SalsaLabs::ApiClient.new(credentials)
    end

    def fetch
      item_nodes.map do |node|
        SalsaLabs::Action.new(SalsaLabsApiObjectNode.new(node).attributes)
      end
    end

    private

    attr_reader :client, :filter_parameters

    def api_call
      client.fetch('/api/getObjects.sjs', api_parameters)
    end

    def api_parameters
      filter_parameters.merge(object: 'Action')
    end

    def item_nodes
      Nokogiri::XML(api_call).css('item')
    end

    ##
    # Object used to translate API's XML node into a hash of attributes for
    # SalsaLabs::Action creation.
    ##
    class SalsaLabsApiObjectNode

      def initialize(xml_element)
        @node = xml_element
      end

      def attributes
        children.inject({}) do |memo, attribute|
          memo[attribute.name.downcase] = attribute.text
          attribute
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
