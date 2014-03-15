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
        params.update({'xml'=>nil}) #tell Salsa we want the response back as XML

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

end
