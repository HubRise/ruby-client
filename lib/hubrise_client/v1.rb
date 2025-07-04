# frozen_string_literal: true
# rubocop:disable Naming/AccessorMethodName
module HubriseClient
  class V1 < Base
    def version
      :v1
    end

    # --------------------
    # Accounts, locations, user
    # --------------------
    def get_account(account_id = nil)
      if account_id
        call_api("/accounts/#{account_id}")
      else
        call_api("/account")
      end
    end

    def get_accounts
      call_api("/accounts")
    end

    def get_user
      call_api("/user")
    end

    def get_locations
      call_api("/locations")
    end

    def get_location(location_id = nil)
      if location_id
        call_api("/locations/#{location_id}")
      else
        call_api("/location")
      end
    end

    def patch_location(location_id, params)
      call_api("/locations/#{location_id}", :patch, data: params)
    end

    # @deprecated Use patch_location instead
    alias_method :update_location, :patch_location

    # --------------------
    # Orders
    # --------------------
    def get_orders(location_id, search_params)
      call_api("/locations/#{location_id}/orders", :get, data: search_params)
    end

    def get_order(location_id, order_id)
      call_api("/locations/#{location_id}/orders/#{order_id}")
    end

    def create_order(location_id, params)
      call_api("/locations/#{location_id}/orders", :post, data: params)
    end

    # @deprecated Use patch_order instead
    def update_order(location_id, order_id, params)
      call_api("/locations/#{location_id}/orders/#{order_id}", :put, data: params)
    end

    def patch_order(location_id, order_id, params)
      call_api("/locations/#{location_id}/orders/#{order_id}", :patch, data: params)
    end

    # --------------------
    # Deliveries
    # --------------------
    def get_delivery(location_id, order_id)
      call_api("/locations/#{location_id}/orders/#{order_id}/delivery")
    end

    def create_delivery(location_id, order_id, params)
      call_api("/locations/#{location_id}/orders/#{order_id}/delivery", :post, data: params)
    end

    def patch_delivery(location_id, order_id, params)
      call_api("/locations/#{location_id}/orders/#{order_id}/delivery", :patch, data: params)
    end

    # --------------------
    # Callback, events
    # --------------------
    def get_callback
      call_api("/callback")
    end

    def get_callback_events
      call_api("/callback/events")
    end

    def delete_event(event_id)
      call_api("/callback/events/#{event_id}", :delete)
    end

    def update_callback(params)
      call_api("/callback", :post, data: params)
    end

    def delete_callback
      call_api("/callback", :delete)
    end

    # --------------------
    # Customer lists, customers
    # --------------------
    def get_location_customer_lists(location_id)
      call_api("/locations/#{location_id}/customer_lists")
    end

    def get_account_customer_lists(account_id)
      call_api("/accounts/#{account_id}/customer_lists")
    end

    def get_customer_list(customer_list_id = nil)
      call_api("/customer_lists/#{customer_list_id_fallback(customer_list_id)}")
    end

    def get_all_customers(customer_list_id = nil)
      search_customers({}, customer_list_id)
    end

    def search_customers(search_params, customer_list_id = nil)
      call_api("/customer_lists/#{customer_list_id_fallback(customer_list_id)}/customers", :get, data: search_params)
    end

    def get_customer(customer_id, customer_list_id = nil)
      call_api("/customer_lists/#{customer_list_id_fallback(customer_list_id)}/customers/#{customer_id}")
    end

    def create_customer(params, customer_list_id = nil)
      call_api("/customer_lists/#{customer_list_id_fallback(customer_list_id)}/customers", :post, data: params)
    end

    def update_customer(customer_id, params, customer_list_id = nil)
      call_api("/customer_lists/#{customer_list_id_fallback(customer_list_id)}/customers/#{customer_id}", :put,
               data: params)
    end

    # --------------------
    # Catalogs
    # --------------------
    def get_location_catalogs(location_id)
      call_api("/locations/#{location_id}/catalogs")
    end

    def get_account_catalogs(account_id)
      call_api("/accounts/#{account_id}/catalogs")
    end

    def get_catalog(catalog_id = nil, hide_data: false)
      query_params = hide_data ? { hide_data: true } : {}
      call_api("/catalogs/#{catalog_id_fallback(catalog_id)}", :get, data: query_params)
    end

    def create_account_catalog(params)
      call_api("/account/catalogs", :post, data: params)
    end

    def create_location_catalog(params, location_id = nil)
      if location_id
        call_api("/locations/#{location_id}/catalogs", :post, data: params)
      else
        call_api("/location/catalogs", :post, data: params)
      end
    end

    def update_catalog(params, catalog_id = nil)
      call_api("/catalogs/#{catalog_id_fallback(catalog_id)}", :put, data: params)
    end

    # --------------------
    # Images
    # --------------------
    def create_image(data, mime_type, catalog_id = nil, options = {})
      path = "/catalogs/#{catalog_id_fallback(catalog_id)}/images"
      path += "?private_ref=#{CGI.escape(options[:private_ref])}" if options[:private_ref]
      call_api(path, :post, data: data, headers: { "Content-Type" => mime_type }, json: false)
    end

    def get_images(catalog_id = nil)
      call_api("/catalogs/#{catalog_id_fallback(catalog_id)}/images")
    end

    def get_image(image_id, catalog_id = nil)
      call_api("/catalogs/#{catalog_id_fallback(catalog_id)}/images/#{image_id}")
    end

    def get_image_data(image_id, catalog_id = nil)
      call_api("/catalogs/#{catalog_id_fallback(catalog_id)}/images/#{image_id}/data")
    end

    # --------------------
    # Inventory
    # --------------------
    def get_inventory(catalog_id = nil, location_id = nil)
      endpoint = inventory_endpoint(catalog_id, location_id)
      call_api(endpoint)
    end

    def update_inventory(params, catalog_id = nil, location_id = nil)
      endpoint = inventory_endpoint(catalog_id, location_id)
      call_api(endpoint, :put, data: params)
    end

    def patch_inventory(params, catalog_id = nil, location_id = nil)
      endpoint = inventory_endpoint(catalog_id, location_id)
      call_api(endpoint, :patch, data: params)
    end

    def inventory_endpoint(catalog_id = nil, location_id = nil)
      if location_id
        "/catalogs/#{catalog_id_fallback(catalog_id)}/locations/#{location_id}/inventory"
      else
        "/catalogs/#{catalog_id_fallback(catalog_id)}/location/inventory"
      end
    end

    private :inventory_endpoint

    # --------------------
    # Loyalty cards
    # --------------------
    def create_loyalty_card(params, customer_list_id = nil)
      call_api("/customer_lists/#{customer_list_id_fallback(customer_list_id)}/loyalty_cards", :post, data: params)
    end

    def create_loyalty_operation(loyalty_card_id, params, customer_list_id = nil)
      call_api(
        "/customer_lists/#{customer_list_id_fallback(customer_list_id)}/loyalty_cards/#{loyalty_card_id}/operations",
        :post,
        data: params
      )
    end

    private

    def customer_list_id_fallback(customer_list_id)
      customer_list_id ||= @customer_list_id
      raise("customer_list_id required") if customer_list_id.nil? || customer_list_id.empty?

      customer_list_id
    end

    def catalog_id_fallback(catalog_id)
      catalog_id ||= @catalog_id
      raise("catalog_id required") if catalog_id.nil? || catalog_id.empty?

      catalog_id
    end
  end
end
