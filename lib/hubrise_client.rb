# frozen_string_literal: true
require "net/http"
require "json"
require "uri"
require "logger"

require_relative "hubrise_client/request"
require_relative "hubrise_client/response"
require_relative "hubrise_client/base"
require_relative "hubrise_client/v1"

module HubriseClient
  class HubriseError              < StandardError; end

  class HubriseAccessTokenMissing < HubriseError; end

  class InvalidHubriseGrantParams < HubriseError; end

  class InvalidHubriseToken       < HubriseError; end
end
