module SalsaLabs
  ##
  # Service object to save an object or a collection of objects to the Salsa Labs API.
  ##
  class SalsaObjectsSaver

    def initialize(credentials = {})
      @client = SalsaLabs::ApiClient.new(credentials)
    end

    def save(attributes)
      parameters = SalsaLabsApiObjectParameterList.new(attributes)
      puts parameters

      api_call.post(parameters)
    end

    private

    attr_reader :client

    def api_call(data)
      client.post('/api/save', data)
    end

    def parse_response(response)
      Nokogiri::XML(response).css('data')
    end

    ##
    # Object used to translate an attributes hash to API's expected parameter list
    # Deals with weird capitalization
    ##
    class SalsaLabsApiObjectParameterList

      def initialize(attributes)
        @attributes = attributes

        capitalize
      end

      def capitalize
        capitalized_attributes = {}

        @attributes.each do |key, value|
          #re-capitalize according to Salsa's unique requirements

          #deal with exceptions first
          if key.end_with? '_key'
            #asdf_key -> asdf_KEY
            parts = key.split('_')
            capitalized_key = [parts[0..-2],parts.last.upcase].join('_')
          elsif key == 'mi'
            #middle initial is special case
            capitalized_key = "MI"
          elsif key == 'uid'
            #uid is always lower case
            capitalized_key = 'uid'
          elsif key.start_with 'private'
            # private_ab_cd_1 -> PRIVATE_Ab_Cd_1
            parts = key.split('_')
            last_parts = parts[1..-1].map{|part| part.capitalize}
            capitalized_key = [parts.first.upcase,last_parts].join('_')
          else
            #all others are capitalized normally
            capitalized_key = (key.split('_').map {|part| part.capitalize}).join('_')
          end

          capitalized_attributes[capitalized_key] = value

          puts capitalized_key
        end

        capitalized_attributes
      end
    end

  end
end
