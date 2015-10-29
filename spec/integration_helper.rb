require 'salsa_labs'
require 'dotenv'
require 'faker'

Dotenv.load

RSpec.configure do |config|
  config.before(:suite) do
    SANDBOX_CREDENTIALS = {email: ENV['SALSA_LABS_API_EMAIL'], password: ENV['SALSA_LABS_API_PASSWORD'], url: ENV['https://sandbox.salsalabs.com']}
  end
end