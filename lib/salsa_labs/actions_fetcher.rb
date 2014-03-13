module SalsaLabs
  ##
  # Service object to pull back a collection of actions from the Salsa Labs API.
  ##
  class ActionsFetcher < SalsaObjectsFetcher 
    def fetch
      item_nodes.map do |node|
        SalsaLabs::Action.new(SalsaLabsApiObjectNode.new(node).attributes)
      end
    end

    private

    def api_parameters
      filter_parameters.merge(object: 'Action')
    end

  end
end
