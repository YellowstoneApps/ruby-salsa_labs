require 'simplecov'
SimpleCov.start

require 'salsa_labs'

require 'vcr'
require 'webmock'

WebMock.disable_net_connect!

RSpec.configure do |config|
  
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :faraday
  c.hook_into :webmock
end
