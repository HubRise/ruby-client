# frozen_string_literal: true
module HubriseClient
  class Response
    attr_reader :code, :failed, :data, :error_type, :error_message, :errors, :http_response
    alias_method :failed?, :failed

    def initialize(http_response, request)
      @http_response = http_response
      @request = request
      @code = http_response.code

      json_body = begin
                    JSON.parse(http_response.body)
                  rescue JSON::ParserError
                    nil
                  end

      @data = json_body || http_response.body

      case http_response
      when Net::HTTPSuccess
        @failed = false
      else
        @failed = true
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

    def each_page
      return enum_for(:each_page) unless block_given?

      yield(self)

      response = self
      while response.next_page?
        response = response.next_page
        yield(response)
      end
    end

    def next_page?
      !!cursor_next
    end

    def next_page
      @request.next_page_request(cursor_next).perform
    end

    def cursor_next
      http_response["X-Cursor-Next"]
    end
  end
end
