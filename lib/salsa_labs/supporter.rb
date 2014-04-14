module SalsaLabs
  class Supporter < SalsaObject
    def email
      attributes['email']
    end

    def supporter_key
      attributes['supporter_key'].to_i
    end

    def self.fetch(credentials = {})
      ObjectsFetcher.fetch(credentials: credentials,
                           type: 'supporter',
                           item_class: self)
    end
  end
end
