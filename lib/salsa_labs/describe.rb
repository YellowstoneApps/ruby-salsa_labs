module SalsaLabs
  class Describe
    attr_accessor :client

    def initialize(client)
      @client = client
    end

    def describe(object)

      ActiveSupport::JSON.decode(@client.fetch("/api/describe2.sjs", json: true, object: object))
    end
  end
end
