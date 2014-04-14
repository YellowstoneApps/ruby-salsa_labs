module SalsaLabs
  class SupporterAction < SalsaObject
    def supporter_key
      attributes['supporter_key'].to_i if attributes['supporter_key']
    end

    def action_key
      attributes['action_key'].to_i if attributes['action_key']
    end

    def supporter_action_key
      attributes['supporter_action_key'].to_i if attributes['supporter_action_key']
    end

    def self.fetch(credentials = {})
      ObjectsFetcher.fetch(type: 'supporter_action',
                           item_class: self,
                           credentials: credentials)
    end
  end
end
