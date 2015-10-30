module SalsaLabs
  ##
  # Action represents a single instance of a member action in
  # the Salsa Labs CRM.
  ##
  class SupporterAction < SalsaObject
    integer_attributes :supporter_action_key, :supporter_key, :action_key, :supporter_action_comment_key

    string_attributes :tracking_code, :salesforce_id, :title
    datetime_attributes :last_modified, :date_created

    def self.fetch(filter_parameters = {}, credentials = {})
      ActionsFetcher.new(filter_parameters, credentials).fetch
    end

    def self.object_name
      'supporter_action'
    end
  end

  ##
  # ActionsFetcher is a service object to pull back a collection of actions from the Salsa Labs API.
  ##
  class SupporterActionsFetcher < SalsaObjectsFetcher
    def initialize(filter_parameters = {}, credentials = {})
      super(filter_parameters, credentials)
      @object_class = SalsaLabs::SupporterAction
    end

    attr_reader :object_parameter
  end
end
