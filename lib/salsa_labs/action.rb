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
end
