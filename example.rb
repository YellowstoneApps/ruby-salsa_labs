$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

require 'salsa_labs'
require 'dotenv'
Dotenv.load

credentials = {email: ENV['SALSA_LABS_API_EMAIL'], password: ENV['SALSA_LABS_API_PASSWORD'], url: ENV['https://sandbox.salsalabs.com']}
client = SalsaLabs::ApiClient.new(credentials)

require 'pry-byebug'
binding.pry

client
