module SalsaLabs
  ##
  # Service object that fetches a collection of objects from API and
  # returns them as instances of a specified class
  ##
  class ObjectsFetcher
    def self.fetch(opts = {})
      filters = opts[:filters] || {}
      credentials = opts[:credentials] || {}
      client = SalsaLabs::ApiClient.new(credentials)
      type = opts.fetch(:type)
      item_class = opts[:item_class] || SalsaLabs::SalsaObject
      new(filters: filters, client: client, type: type, item_class: item_class)
    end

    def initialize(opts = {})
      @filters = opts[:filters]
      @client = opts[:client]
      @type = opts[:type]
      @item_class = opts[:item_class]
    end

    def fetch
      item_nodes.map do |node|
        item_class.new(SalsaLabsApiObjectNode.new(node).attributes)
      end
    end

    private

    attr_reader :client, :filters, :type, :item_class

    def api_call
      client.fetch('/api/getObjects.sjs', api_parameters)
    end

    def api_parameters
      filters.merge(object: type)
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
          memo[attribute.name.downcase] = attribute.text if attribute.element?
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
