require 'faraday'
require 'nokogiri'

require 'salsa_labs/version'
require 'salsa_labs/api_client'
require 'salsa_labs/salsa_object'
require 'salsa_labs/action'
require 'salsa_labs/actions_fetcher'
require 'salsa_labs/supporter'

module SalsaLabs

  ##
  # Exception class for API-related errors.
  ##
  class Error < StandardError
  end

end
