module SalsaLabs
  ##
  # Action represents a single instance of an advocacy campaign ("Action") in
  # the Salsa Labs / DemocracyInAction CRM.
  ##
  class Action < SalsaObject
    def action_key
      (attributes['action_key'] || 0).to_i
    end

    def chapter_key
      attributes['chapter_key'].to_i if attributes['chapter_key']
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
      ObjectsFetcher.fetch(type: 'Action', item_class: self,
                           credentials: credentials)
    end
  end
end
