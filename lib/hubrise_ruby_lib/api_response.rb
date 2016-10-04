module Hubrise
  class APIResponse
    attr_reader :code, :failed, :data, :error_type, :error_message, :errors
    alias_method :failed?, :failed

    def initialize(http_response)
      @http_response  = http_response
      @code           = http_response.code
      json_body       = JSON.parse(http_response.body) rescue nil

      case http_response
      when Net::HTTPSuccess
        @failed  = false
        @data    = json_body
      else
        @failed  = true
        if json_body
          @errors         = json_body['errors']
          @error_type     = json_body['error_type']
          @error_message  = json_body['message']
        end
      end
    end
  end
end