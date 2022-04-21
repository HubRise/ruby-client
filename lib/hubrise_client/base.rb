# frozen_string_literal: true
module HubriseClient
  class Base
    USE_HTTPS           = true
    DEFAULT_API_HOST    = "api.hubrise.com"
    DEFAULT_API_PORT    = "443"
    DEFAULT_OAUTH_HOST  = "manager.hubrise.com"
    DEFAULT_OAUTH_PORT  = "443"

    attr_accessor :access_token,
                  :app_instance_id,
                  :user_id,
                  :account_id,
                  :location_id,
                  :catalog_id,
                  :customer_list_id,
                  :logger,
                  :request_callback

    def initialize(app_id, app_secret, params = {})
      @app_id = app_id
      @app_secret = app_secret
      @api_host = params[:api_host] || DEFAULT_API_HOST
      @api_port = params[:api_port] || DEFAULT_API_PORT
      @oauth_host = params[:oauth_host] || DEFAULT_OAUTH_HOST
      @oauth_port = params[:oauth_port] || DEFAULT_OAUTH_PORT
      @use_https = !!params.fetch(:use_https, USE_HTTPS)
      @request_callback = params[:request_callback]

      initialize_scope_params(params)

      @verbous = !!params[:verbous]
      unless (@logger = params[:logger])
        @logger = Logger.new(STDOUT)
        @logger.level = @verbous ? Logger::DEBUG : Logger::WARN
      end
    end

    def build_authorization_url(redirect_uri, scope, params = {})
      params = params.merge(
        redirect_uri: redirect_uri,
        scope: scope,
        client_id: @app_id
      )

      (@use_https ? "https" : "http") + "://" + oauth2_hubrise_hostname_with_version + "/authorize?" + URI.encode_www_form(params) # rubocop:disable Metrics/LineLength
    end

    def authorize!(authorization_code)
      api_response = api_request(
        oauth2_hubrise_hostname_with_version, "/token", :post, data: {
          client_id: @app_id,
          client_secret: @app_secret,
          code: authorization_code,
        }
      ).perform

      case api_response.code
      when "200"
        initialize_scope_params(api_response.data)
      when "404"
        raise InvalidHubriseGrantParams
      else
        raise HubriseError, "Unexpected error: #{api_response.http_response.inspect}"
      end

      self
    end

    protected

    def initialize_scope_params(params)
      @access_token = params[:access_token] || params["access_token"]
      @app_instance_id = params[:app_instance_id] || params["app_instance_id"]
      @user_id = params[:user_id] || params["user_id"]
      @account_id = params[:account_id] || params["account_id"]
      @location_id = params[:location_id] || params["location_id"]
      @catalog_id = params[:catalog_id] || params["catalog_id"]
      @customer_list_id = params[:customer_list_id] || params["customer_list_id"]
    end

    def call_api(path, method = :get, data: {}, headers: {}, json: true)
      raise(HubriseAccessTokenMissing) if @access_token.nil?

      api_request(
        "#{@api_host}:#{@api_port}/#{version}", path, method, data: data,
                                                              json: json,
                                                              headers: headers,
                                                              access_token: @access_token,
                                                              callback: @request_callback
      ).perform
    end

    def api_request(hostname, path, method, attrs = {})
      Request.from_h(
        {
          hostname: hostname,
          path: path,
          method: method,
          use_https: @use_https,
          logger: @verbous && @logger,
          json: true,
        }.merge(attrs)
      )
    end

    def oauth2_hubrise_hostname_with_version
      "#{@oauth_host}:#{@oauth_port}/oauth2/#{version}"
    end
  end
end
