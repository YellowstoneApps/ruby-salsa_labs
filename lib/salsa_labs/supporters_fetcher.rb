module SalsaLabs
  ##
  # Service object to pull back a collection of actions from the Salsa Labs API.
  ##
  class SupportersFetcher < SalsaObjectsFetcher 
    def initialize(filter_parameters = {}, credentials = {})
      super(filter_parameters, credentials)
      @object_parameter = 'supporter'
    end

    attr_reader :object_parameter

    def fetch
      item_nodes.map do |node|
        SalsaLabs::Supporter.new(ApiObjectNode.new(node).attributes)
      end
    end

  end
end
