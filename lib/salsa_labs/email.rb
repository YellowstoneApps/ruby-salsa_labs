module SalsaLabs
  ##
  # Action represents a single instance of a member action in
  # the Salsa Labs CRM.
  ##
  class Email < SalsaObject
    integer_attributes :email_key, :supporter_key, :email_blast_key, :status_count, :thread_id
    string_attributes :status
    datetime_attributes :last_modified, :time_requested, :time_sent

    def self.fetch(filter_parameters = {}, credentials = {})
      EmailsFetcher.new(filter_parameters, credentials).fetch
    end

  end

  ##
  # ActionsFetcher is a service object to pull back a collection of actions from the Salsa Labs API.
  ##
  class EmailsFetcher < SalsaObjectsFetcher
    def initialize(filter_parameters = {}, credentials = {})
      super(filter_parameters, credentials)
      @object_class = SalsaLabs::Email
    end

    attr_reader :object_parameter
  end
end
