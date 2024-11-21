# frozen_string_literal: true
module HubriseClient
  class Request < Struct.new(:hostname,
                             :path,
                             :method,
                             :data,
                             :access_token,
                             :use_https,
                             :logger,
                             :json,
                             :headers,
                             :callback)

    REQUESTS_HASH = {
      get: Net::HTTP::Get,
      post: Net::HTTP::Post,
      put: Net::HTTP::Put,
      patch: Net::HTTP::Patch,
      delete: Net::HTTP::Delete,
    }.freeze

    def self.from_h(hash)
      new(*hash.values_at(*members))
    end

    attr_reader :http_request

    def perform
      @http_request = build_request

      @http_response = perform_request(@http_request)
      @response = Response.new(@http_response, self)

      case @http_response
      when Net::HTTPUnauthorized
        raise InvalidHubriseToken
      else
        raise(HubriseError, "Unexpected error") if @http_response.code.start_with?("5")

        @response
      end
    rescue Errno::ECONNREFUSED => e
      raise HubriseError, "API is not reachable: #{e}"
    ensure
      callback.call(self, @response) if @http_request && callback
    end

    def next_page_request(new_cursor)
      new_data = data || {}
      new_data[:cursor] = new_cursor

      Request.from_h(to_h.merge(data: new_data))
    end

    protected

    def protocol
      use_https ? "https" : "http"
    end

    def build_request
      request_uri = URI.parse(protocol + "://" + hostname + path)

      request_headers = headers || {}
      request_headers["X-Access-Token"] = access_token if access_token

      request_body_data = nil

      if method == :get
        request_uri = add_params_to_uri(request_uri, data) if data && !data.empty?
      elsif json
        request_headers["Content-Type"] ||= "application/json"
        request_body_data = data.to_json
      else
        request_body_data = data
      end

      REQUESTS_HASH[method].new(request_uri, request_headers).tap do |request|
        request.body = request_body_data
      end
    end

    def add_params_to_uri(uri, params)
      uri.query = [uri.query, URI.encode_www_form(params)].compact.join("&")
      uri
    end

    def perform_request(request)
      uri = request.uri

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = use_https
      http.set_debug_output(logger) if logger
      http.request(request)
    end
  end
end
