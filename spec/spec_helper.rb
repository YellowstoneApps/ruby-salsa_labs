require 'simplecov'
SimpleCov.start

require 'salsa_labs'

require 'vcr'
require 'webmock/rspec'

WebMock.disable_net_connect!

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :faraday
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end
