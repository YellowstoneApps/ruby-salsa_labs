require 'simplecov'
SimpleCov.start

require 'salsa_labs'

require 'rspec/autorun'
require 'vcr'
require 'webmock'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :faraday
  c.hook_into :webmock
end
