# frozen_string_literal: true
module HubriseClient
  class Request
    REQUESTS_HASH = {
      get: Net::HTTP::Get,
      post: Net::HTTP::Post,
      put: Net::HTTP::Put,
      patch: Net::HTTP::Patch,
      delete: Net::HTTP::Delete,
    }.freeze

    attr_reader :http_request
    def initialize(hostname:, access_token: nil, use_https: false, logger: nil)
      @hostname     = hostname
      @access_token = access_token
      @use_https    = use_https
      @protocol     = use_https ? "https" : "http"
      @logger       = logger
    end

    def perform(method, path, data, json: true, headers: {})
      uri = URI.parse(@protocol + "://" + @hostname + path)
      @http_request = build_request(uri, method, data, json: json, headers: headers)
      @http_response = perform_request(uri, @http_request)
      @response = Response.new(@http_response)

      case @http_response
      when Net::HTTPUnauthorized
        raise InvalidHubriseToken
      else
        raise(HubriseError, "Unexpected error") if @http_response.code.start_with?("5")

        @response
      end
    rescue Errno::ECONNREFUSED
      raise HubriseError, "API is not reachable"
    ensure
      yield(self, @response) if @http_request && block_given?
    end

    protected

    def build_request(uri, method, data, json:, headers:)
      headers["X-Access-Token"] = @access_token if @access_token

      if method == :get
        uri = add_params_to_uri(uri, data) if data&.count&.positive?

        data = nil
      elsif json
        headers["Content-Type"] ||= "application/json"
        data = data.to_json
      end

      REQUESTS_HASH[method].new(uri, headers).tap do |request|
        request.body = data
      end
    end

    def add_params_to_uri(uri, params)
      uri.query = [uri.query, URI.encode_www_form(params)].compact.join("&")
      uri
    end

    def perform_request(uri, request)
      http          = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl  = @use_https
      http.set_debug_output(@logger) if @logger
      http.request(request)
    end
  end
end
