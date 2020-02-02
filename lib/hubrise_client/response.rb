module HubriseClient
  class Response
    attr_reader :code, :failed, :data, :error_type, :error_message, :errors, :http_response
    alias failed? failed

    def initialize(http_response)
      @http_response  = http_response
      @code           = http_response.code

      json_body = begin
                    JSON.parse(http_response.body)
                  rescue JSON::ParserError
                    nil
                  end

      @data = json_body || http_response.body

      case http_response
      when Net::HTTPSuccess
        @failed  = false
      else
        @failed  = true
        if json_body
          @errors         = json_body["errors"]
          @error_type     = json_body["error_type"]
          @error_message  = json_body["message"]
        end
      end
    end

    def retry_after
      http_response.is_a?(Net::HTTPTooManyRequests) && http_response["retry-after"].to_i
    end
  end
end
