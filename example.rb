$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

require 'salsa_labs'
require 'dotenv'
Dotenv.load

client = SalsaLabs::ApiClient.new

credentials = {email: ENV['SALSA_LABS_API_EMAIL'], password: ENV['SALSA_LABS_API_PASSWORD'], url: ENV['https://sandbox.salsalabs.com']}

require 'pry-debugger'
binding.pry