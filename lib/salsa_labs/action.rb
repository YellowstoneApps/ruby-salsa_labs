module SalsaLabs
  ##
  # Action represents a single instance of a member action in
  # the Salsa Labs CRM.
  ##
  class Action < SalsaObject
    integer_attributes :action_key
    string_attributes :description, :reference_name, :title

    def self.fetch(filter_parameters = {}, credentials = {})
      ActionsFetcher.new(filter_parameters, credentials).fetch
    end

  end

  ##
  # ActionsFetcher is a service object to pull back a collection of actions from the Salsa Labs API.
  ##
  class ActionsFetcher < SalsaObjectsFetcher 
    def initialize(filter_parameters = {}, credentials = {})
      super(filter_parameters, credentials)
      @object_class = SalsaLabs::Action
    end

    attr_reader :object_parameter
  end
end
