module SalsaLabs
  ##
  # Supporter represents a single member in the Salsa Labs CRM.
  # Standard field list from documentation at
  #   https://help.salsalabs.com/entries/21518315-Standard-supporter-fields-the-supporter-object-
  ##
  class Supporter < SalsaObject
    integer_attributes :supporter_key, :chapter_key
    string_attributes :title, :first_name, :last_name, :mi, :suffix, :email, :phone, :street, :street_2, :city, :state,
                      :zip, :country, :source, :status

    boolean_attributes :receive_email

    def self.fetch(filter_parameters = {}, credentials = {})
      SupportersFetcher.new(filter_parameters, credentials).fetch
    end

  end
end
