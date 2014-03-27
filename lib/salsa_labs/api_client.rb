module SalsaLabs
  ##
  # Used to request information from Salsa Labs. Handles cookie-based
  # authentication, and raises an exception when the API returns an error.
  ##
  class ApiClient

    attr_reader :authentication_cookie

    def initialize(credentials = {})
      @email = credentials[:email] || ENV['SALSA_LABS_API_EMAIL']
      @password = credentials[:password] || ENV['SALSA_LABS_API_PASSWORD']
      @api_url = credentials[:url] || ENV['SALSA_LABS_API_URL']
      if not @api_url
        @api_url = 'https://hq-salsa.wiredforchange.com'
      end

      @authenticated = false
    end

    def authenticate
      return true if authenticated?

      response = authenticate!

      @authentication_cookie = response.env[:response_headers]["set-cookie"]
      @authenticated = Nokogiri::XML(response.body).css('error').empty?
    end

    def authenticated?
      @authenticated
    end

    def fetch(endpoint, params)
      authenticate unless authenticated?

      perform_get_request(endpoint, params).body
    end

    def post(endpoint, params)
      authenticate unless authenticated?

      perform_post_request(endpoint, params).body
    end

    private

    attr_reader :authenticated,
      :email,
      :password

    def authenticate!
      perform_get_request(
        '/api/authenticate.sjs',
        authentication_parameters
      )
    end

    def authentication_parameters
      {email: email, password: password}
    end

    def connection
      @connection ||= Faraday.
        new(url: @api_url) do |faraday|
        
        faraday.use Faraday::Request::UrlEncoded
        Faraday::Utils.default_params_encoder = Faraday::FlatParamsEncoder #do not nest repeated parameters
        faraday.adapter Faraday.default_adapter
      end
    end

    def perform_get_request(endpoint, params)
      response = connection.get do |request|
        request.headers['cookie'] = authentication_cookie.to_s
        request.url(endpoint, params)
      end

      raise_if_error!(response)

      response
    end

    def perform_post_request(endpoint, params)
      response = connection.post do |request|
        request.headers['cookie'] = authentication_cookie.to_s
        params.update({'xml'=>true}) #tell Salsa we want the response back as XML

        request.url(endpoint, params)
      end

      raise_if_error!(response)

      response
    end

    def raise_if_error!(response)
      # Raise SalsaLabs::Error if response.body contains error (need to do this
      # because API always gives 200 but then gives an error in the XML).
      errors = Nokogiri::XML(response.body).css('error')

      if errors.any?
        raise SalsaLabs::Error.new(response),
          "There is an error: #{errors.first.text}"
      end
    end
  end


  ##
  # Object used to translate an attributes hash to API's expected parameter list
  # Deals with weird capitalization
  ##
  class ApiObjectParameterList

    def initialize(attributes)
      @attributes = attributes
      capitalize!
    end

    def capitalize
      capitalized_attributes = {}

      @attributes.each do |key, value|
        #re-capitalize according to Salsa's unique requirements

        #deal with exceptions first
        if ['key','object','tag'].include? key
          #no change, these must not be capitalized
          capitalized_key = key
        elsif key.end_with? '_key'
          #asdf_key -> asdf_KEY
          parts = key.split('_')
          capitalized_key = [parts[0..-2],parts.last.upcase].join('_')
        elsif key == 'mi'
          #middle initial is special case
          capitalized_key = "MI"
        elsif key == 'uid'
          #uid is always lower case
          capitalized_key = 'uid'
        elsif key.start_with? 'private'
          # private_ab_cd_1 -> PRIVATE_Ab_Cd_1
          parts = key.split('_')
          last_parts = parts[1..-1].map{|part| part.capitalize}
          capitalized_key = [parts.first.upcase,last_parts].join('_')
        else
          #all others are capitalized normally
          capitalized_key = (key.split('_').map {|part| part.capitalize}).join('_')
        end

        capitalized_attributes[capitalized_key] = value
      end

      capitalized_attributes
    end

    def capitalize!
      @attributes = capitalize
    end

    attr_reader :attributes
  end

end
