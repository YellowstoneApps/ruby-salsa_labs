require 'faraday'
require 'nokogiri'

require 'salsa_labs/version'
require 'salsa_labs/api_client'
require 'salsa_labs/salsa_object'
require 'salsa_labs/salsa_objects_fetcher'
require 'salsa_labs/salsa_objects_saver'
require 'salsa_labs/action'
require 'salsa_labs/describe'
require 'salsa_labs/supporter'
require 'active_support/core_ext/hash'
require 'active_support/json'

module SalsaLabs

  ##
  # Exception class for API-related errors.
  ##
  class Error < StandardError
  end

end
