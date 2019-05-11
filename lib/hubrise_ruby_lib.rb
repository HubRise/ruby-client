require 'net/http'
require 'json'
require 'uri'
require 'logger'

require_relative 'hubrise_ruby_lib/api_request'
require_relative 'hubrise_ruby_lib/api_response'
require_relative 'hubrise_ruby_lib/api_clients/base'
require_relative 'hubrise_ruby_lib/api_clients/v1'

module Hubrise
  class HubriseError              < StandardError; end
  class HubriseAccessTokenMissing < HubriseError; end
  class InvalidHubriseGrantParams < HubriseError; end
  class InvalidHubriseToken       < HubriseError; end
end
