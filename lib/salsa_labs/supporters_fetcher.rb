module SalsaLabs
  ##
  # Service object to pull back a collection of actions from the Salsa Labs API.
  ##
  class SupportersFetcher < SalsaObjectsFetcher 
    def fetch
      item_nodes.map do |node|
        SalsaLabs::Supporter.new(SalsaLabsApiObjectNode.new(node).attributes)
      end
    end

    private

    def api_parameters
      filter_parameters.merge(object: 'Supporter')
    end

  end
end
