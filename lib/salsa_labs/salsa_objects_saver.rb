module SalsaLabs
  ##
  # Service object to save an object or a collection of objects to the Salsa Labs API.
  ##
  class SalsaObjectsSaver

    def initialize(credentials = {})
      @client = SalsaLabs::ApiClient.new(credentials)
    end

    def save(data)
      parameters = SalsaLabs::ApiObjectParameterList.new(data)
      response = parse_response(api_call(parameters.attributes))
      if response.css('success')
        return response.css('success').attribute('key').value.to_i
      else
        raise SalsaLabs::Error.new(response),
          "Unable to save object: #{response}"
        return false
      end
    end

    #should this be a separate method?
    #or dispatch within save based on argument type?
    def save_many(collection)
      collection.each do |data|
        save(data)
      end
    end

    private

    attr_reader :client

    def api_call(data)
      client.post('/save', data)
    end

    def parse_response(response)
      Nokogiri::XML(response).css('data')
    end

  end
end