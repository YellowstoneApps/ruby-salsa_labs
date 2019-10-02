require 'spec_helper'
require 'vcr'

describe SalsaLabs::ApiClient do
  let(:api_client) do
    SalsaLabs::ApiClient.new({
      email: 'allison@example.com', password: 'password'
    })
  end

  describe "#authenticate" do
    it "stores the cookie from Salsa Labs" do
      VCR.use_cassette 'successful_authentication',
        match_requests_on: [:host, :path] do

        api_client.authenticate

        expect(api_client.authentication_cookie).to eq(
          'JSESSIONID=67EBA60BFE7BCF73E2BA0B8E6F9592D0-n2; Path=/; Secure; '\
          'HttpOnly, hqtab_2=""; Expires=Thu, 01-Jan-1970 00:00:10 GMT, '\
          'READONLY_Short_Name=""; Expires=Thu, 01-Jan-1970 00:00:10 GMT, '\
          'SRV=vweb213; path=/'
        )
      end
    end

    context "with proper credentials" do
      it "sets authenticated to be true" do
        VCR.use_cassette 'successful_authentication',
          match_requests_on: [:host, :path] do

          api_client.authenticate

          expect(api_client.authenticated?).to be_truthy
        end
      end

    end

    context "with improper credentials" do
      it "raises an exception" do
        VCR.use_cassette 'unsuccessful_authentication',
          match_requests_on: [:host, :path] do

          expect{
            api_client.authenticate
          }.to raise_error(SalsaLabs::Error)
        end
      end
    end
  end

  describe "#authenticated?" do
    it "returns the value of the instance variable @authenticated" do
      api_client.instance_variable_set(:@authenticated, 123)

      expect(api_client.authenticated?).to eq(123)
    end
  end

  describe "#fetch" do
    it "returns the body of the response from Salsa Labs for that API call" do
      VCR.use_cassette 'get_objects/action',
        match_requests_on: [:host, :path] do

        data = api_client.fetch('/api/getObjects.sjs', object: 'Action')

        expect(data.gsub(/\n|\s{2,}/, "")).
           to eq(salsa_get_objects_for_action_xml_response)
      end
    end
  end

  it "can be configured with Salsa API host" do
    url = "https://example.com/api/authenticate.sjs?email=allison@example.com&password=password"
    successful_login = File.read('spec/fixtures/successful_login.xml')
    stub_request(:get, url).to_return(body: successful_login)

    SalsaLabs::ApiClient.new(email: 'allison@example.com',
                             password: 'password',
                             host: 'example.com').authenticate

    WebMock.should have_requested(:get, url)
  end

  def salsa_get_objects_for_action_xml_response
    File.read('spec/fixtures/getObjects.sjs_action.xml').gsub(/\n|\s{2,}/, '')
  end

end
