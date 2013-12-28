module SalsaLabs
  ##
  # Action represents a single instance of an advocacy campaign ("Action") in
  # the Salsa Labs / DemocracyInAction CRM.
  ##
  class Action < SalsaObject

    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
    end

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

    def self.fetch(credentials = {})
      ActionsFetcher.new(credentials).fetch
    end

  end
end
