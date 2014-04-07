$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

require 'salsa_labs'
require 'dotenv'
Dotenv.load

client = SalsaLabs::ApiClient.new

require 'pry-debugger'
binding.pry