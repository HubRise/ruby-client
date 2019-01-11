module Hubrise
  module APIClients
    class HubriseStandardError        < StandardError; end
    class HubriseAccessTokenMissing   < HubriseStandardError; end
    class InvalidHubriseGrantParams   < HubriseStandardError; end
    class InvalidHubriseToken         < HubriseStandardError; end

    class Base
      USE_HTTPS           = true
      DEFAULT_API_HOST    = 'api.hubrise.com'
      DEFAULT_API_PORT    = '433'
      DEFAULT_OAUTH_HOST  = 'manager.hubrise.com'
      DEFAULT_OAUTH_PORT  = '433'

      REQUESTS_HASH = {
        get:    Net::HTTP::Get,
        post:   Net::HTTP::Post,
        put:    Net::HTTP::Put,
        delete: Net::HTTP::Delete
      }

      attr_accessor :access_token,
                    :app_instance_id,
                    :user_id,
                    :account_id,
                    :location_id,
                    :catalog_id,
                    :customer_list_id,
                    :logger

      def self.register(version)
        APIClientsFactory.register_version(version, self)
      end

      def initialize(app_id, app_secret, params = {})
        @app_id           = app_id
        @app_secret       = app_secret
        @access_token     = params[:access_token]
        @app_instance_id  = params[:app_instance_id]
        @user_id          = params[:user_id]
        @account_id       = params[:account_id]
        @location_id      = params[:location_id]
        @catalog_id       = params[:catalog_id]
        @customer_list_id = params[:customer_list_id]

        @api_host       = params[:api_host] || DEFAULT_API_HOST
        @api_port       = params[:api_port] || DEFAULT_API_PORT
        @oauth_host     = params[:oauth_host] || DEFAULT_OAUTH_HOST
        @oauth_port     = params[:oauth_port] || DEFAULT_OAUTH_PORT
        @use_https      = !!params.fetch(:use_https, USE_HTTPS)

        unless @logger = params[:logger]
          @logger = Logger.new(STDOUT)
          @logger.level = !!params[:verbous] ? Logger::DEBUG : Logger::WARN
        end
      end

      def build_authorization_url(redirect_uri, scope, params = {})
        safe_params = params.merge(
          redirect_uri:  redirect_uri,
          scope:         scope,
          client_id:     @app_id
        )

        oauth2_hubrise_hostname_with_version + '/authorize?' + URI.encode_www_form(safe_params)
      end

      def authorize!(authorization_code)
        request_token_and_remember!(authorization_code)
        self
      end

      protected

      def http_request(uri, request)
        http          = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl  = @use_https
        http.set_debug_output(logger) if logger.debug?
        http.request(request)
      end

      def request_token_and_remember!(authorization_code)
        uri           = URI(oauth2_hubrise_hostname_with_version + '/token')
        request       = build_json_request(uri, :post, {
          client_id:      @app_id,
          client_secret:  @app_secret,
          code:           authorization_code
        })

        http_response = http_request(uri, request)

        case http_response
        when Net::HTTPSuccess
          json_body         = JSON.parse(http_response.body)
          @access_token     = json_body['access_token']
          @app_instance_id  = json_body['app_instance_id']
          @user_id          = json_body['user_id']
          @account_id       = json_body['account_id']
          @location_id      = json_body['location_id']
          @catalog_id       = json_body['catalog_id']
          @customer_list_id = json_body['customer_list_id']
        when Net::HTTPNotFound
          raise InvalidHubriseGrantParams, 'Invalid authorization code'
        else
          raise HubriseStandardError, 'Unexpected error'
        end
      end

      def api_json_call(path, method = :get, data = {})
        uri     = URI.parse(api_hostname_with_version + path)
        request = build_json_request(uri, method, data)

        api_call(uri, request)
      end

      def api_call(uri, request)
        raise(HubriseAccessTokenMissing) if access_token.nil?

        http_response = http_request(uri, request)

        case http_response
        when Net::HTTPUnauthorized
          raise InvalidHubriseToken
        else
          if http_response.code.starts_with?('5')
            raise HubriseStandardError, 'Unexpected error'
          else
            APIResponse.new(http_response)
          end
        end
      rescue Errno::ECONNREFUSED
        raise HubriseStandardError, 'API is not reachable'
      end

      def api_hostname_with_version
        "#{protocol}://#{@api_host}:#{@api_port}/#{version}"
      end

      def oauth2_hubrise_hostname_with_version
        "#{protocol}://#{@oauth_host}:#{@oauth_port}/oauth2/#{version}"
      end

      def protocol
        @use_https ? 'https' : 'http'
      end

      def version
        raise NotImplementedError.new
      end

      def build_json_request(uri, method, data, headers = {})
        if method == :get
          uri  = add_params_to_uri(uri, data)
          data = nil
        else
          data = data.to_json
          headers.merge!('Content-Type' => 'application/json')
        end

        build_request(uri, method, data, headers)
      end

      def build_request(uri, method, data, headers = {})
        request = REQUESTS_HASH[method].new(
          uri, headers.merge('X-Access-Token' => access_token || '')
        )
        request.body = data
        request
      end

      def add_params_to_uri(uri, params = {})
        uri.query = [uri.query, URI.encode_www_form(params)].compact.join('&')
        uri
      end
    end
  end
end
