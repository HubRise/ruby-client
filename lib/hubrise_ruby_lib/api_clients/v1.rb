module Hubrise
  module APIClients
    class V1 < Base
      VERSION = :v1
      register(VERSION)

      def version
        VERSION
      end

      # --------------------
      # Accounts, locations, user
      # --------------------
      def get_account(account_id = nil)
        path = account_id ? "/accounts/#{account_id}" : '/account'
        api_call(path)
      end

      def get_accounts
        api_call('/accounts')
      end

      def get_user
        api_call('/user')
      end

      def get_locations
        api_call('/locations')
      end

      def get_location(location_id = nil)
        if location_id
          api_call("/locations/#{location_id}")
        else
          api_call('/location')
        end
      end

      # --------------------
      # Orders
      # --------------------
      def get_orders(location_id, search_params)
        api_call("/locations/#{location_id}/orders", :get, search_params)
      end

      def get_order(location_id, order_id)
        api_call("/locations/#{location_id}/orders/#{order_id}")
      end

      def create_order(location_id, params)
        api_call("/locations/#{location_id}/orders", :post, params)
      end

      def update_order(location_id, order_id, params)
        api_call("/locations/#{location_id}/orders/#{order_id}", :put, params)
      end

      # --------------------
      # Callback, events
      # --------------------
      def get_callback
        api_call('/callback')
      end

      def get_callback_events
        api_call('/callback/events')
      end

      def delete_event(event_id)
        api_call("/callback/events/#{event_id}", :delete)
      end

      def update_callback(params)
        api_call('/callback', :post, params)
      end

      def delete_callback
        api_call('/callback', :delete)
      end

      # --------------------
      # Customer lists, customers
      # --------------------
      def get_location_customer_lists(location_id)
        api_call("/locations/#{location_id}/customer_lists")
      end

      def get_account_customer_lists(account_id)
        api_call("/accounts/#{account_id}/customer_lists")
      end

      def get_customer_list(customer_list_id = nil)
        api_call("/customer_lists/#{customer_list_id_fallback(customer_list_id)}")
      end

      def get_all_customers(customer_list_id = nil)
        search_customers({}, customer_list_id)
      end

      def search_customers(search_params, customer_list_id = nil)
        api_call("/customer_lists/#{customer_list_id_fallback(customer_list_id)}/customers", :get, search_params)
      end

      def get_customer(customer_id, customer_list_id = nil)
        api_call("/customer_lists/#{customer_list_id_fallback(customer_list_id)}/customers/#{customer_id}")
      end

      def create_customer(params, customer_list_id = nil)
        api_call("/customer_lists/#{customer_list_id_fallback(customer_list_id)}/customers", :post, params)
      end

      def update_customer(customer_id, params, customer_list_id = nil)
        api_call("/customer_lists/#{customer_list_id_fallback(customer_list_id)}/customers/#{customer_id}", :put, params)
      end

      # --------------------
      # Catalogs
      # --------------------
      def get_location_catalogs(location_id)
        api_call("/locations/#{location_id}/catalogs")
      end

      def get_account_catalogs(account_id)
        api_call("/accounts/#{account_id}/catalogs")
      end

      def get_catalog(catalog_id = nil)
        api_call("/catalogs/#{catalog_id_fallback(catalog_id)}")
      end

      def create_account_catalog(params)
        api_call("/account/catalogs", :post, params)
      end

      def create_location_catalog(params, location_id = nil)
        if location_id
          api_call("/locations/#{location_id}/catalogs", :post, params)
        else
          api_call("/location/catalogs", :post, params)
        end
      end

      def update_catalog(params, catalog_id = nil)
        api_call("/catalogs/#{catalog_id_fallback(catalog_id)}", :put, params)
      end

      private

      def customer_list_id_fallback(customer_list_id)
        customer_list_id ||= @customer_list_id
        raise('customer_list_id required') if customer_list_id.nil? || customer_list_id.empty?
        customer_list_id
      end

      def catalog_id_fallback(catalog_id)
        catalog_id ||= @catalog_id
        raise('catalog_id required') if catalog_id.nil? || catalog_id.empty?
        catalog_id
      end
    end
  end
end
