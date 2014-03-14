module SalsaLabs
  ##
  # Action represents a single instance of a member action in
  # the Salsa Labs CRM.
  ##
  class Action < SalsaObject

    def action_key
      (attributes['action_key'] || 0).to_i
    end

    def description
      attributes['description']
    end

    def reference_name
      attributes['reference_name']
    end

    def title
      attributes['title']
    end

    def self.fetch(filter_parameters = {}, credentials = {})
      ActionsFetcher.new(filter_parameters, credentials).fetch
    end

  end
end
