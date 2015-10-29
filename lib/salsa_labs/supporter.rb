module SalsaLabs
  ##
  # Supporter represents a single member in the Salsa Labs CRM.
  # Standard field list from documentation at
  #   https://help.salsalabs.com/entries/21518315-Standard-supporter-fields-the-supporter-object-
  ##
  class Supporter < SalsaObject
    integer_attributes :supporter_key, :chapter_key
    string_attributes :title, :first_name, :last_name, :mi, :suffix, :email, :phone, :street, :street_2, :city, :state,
                      :zip, :country, :source, :status, :timezone, :language_code, :source_tracking_code, :source_details,
                      :tracking_code, :date_created

    boolean_attributes :receive_email

    def self.fetch(filter_parameters = {}, credentials = {})
      SupportersFetcher.new(filter_parameters, credentials).fetch
    end

    def self.tagged(tag, filter_parameters={}, credentials = {})
      SupportersFetcher.new(filter_parameters).tagged(tag)
    end

    def tracking_info_blank?
      (self.source_details.blank? && self.source_tracking_code.blank?) || (self.source_details =~ /No Referring info/ &&  self.source_tracking_code =~ /No Original Source/)
    end
  end

  ##
  # SupportersFetcher is a service object to pull back a collection of supporters from the Salsa Labs API.
  ##
  class SupportersFetcher < SalsaObjectsFetcher 
    def initialize(filter_parameters = {}, credentials = {})
      super(filter_parameters, credentials)
      @object_class = SalsaLabs::Supporter
    end

    attr_reader :object_class
  end
end
