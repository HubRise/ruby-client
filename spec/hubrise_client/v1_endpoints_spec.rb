# frozen_string_literal: true
require "spec_helper"
describe HubriseClient::V1 do
  let(:client) { HubriseClient::V1.new(nil, nil, access_token: "access_token1") }

  {
    get_account: {
      [{}, ["accountIdX"]] => [:get, "/accounts/accountIdX"],
      [{}, []] => [:get, "/account"],
    },
    get_accounts: {
      [{}, []] => [:get, "/accounts"],
    },
    get_user: {
      [{}, []] => [:get, "/user"],
    },
    get_locations: {
      [{}, []] => [:get, "/locations"],
    },
    get_location: {
      [{}, ["locationIdX"]] => [:get, "/locations/locationIdX"],
      [{}, []] => [:get, "/location"],
    },
    patch_location: {
      [{}, ["locationIdX", { cutoff_time: "06:00" }]] => [:patch, "/locations/locationIdX", { body: { cutoff_time: "06:00" }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
    get_orders: {
      [{}, ["locationIdX", { status: "new" }]] => [:get, "/locations/locationIdX/orders?status=new"],
    },
    get_order: {
      [{}, ["locationIdX", "orderIdX"]] => [:get, "/locations/locationIdX/orders/orderIdX"],
    },
    create_order: {
      [{}, ["locationIdX", { status: "new" }]] => [:post, "/locations/locationIdX/orders", { body: { status: "new" }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
    update_order: {
      [{}, ["locationIdX", "orderIdX", { status: "delivered" }]] => [:put, "/locations/locationIdX/orders/orderIdX", { body: { status: "delivered" }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
    patch_order: {
      [{}, ["locationIdX", "orderIdX", { status: "delivered" }]] => [:patch, "/locations/locationIdX/orders/orderIdX", { body: { status: "delivered" }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
    get_delivery: {
      [{}, ["locationIdX", "orderIdX"]] => [:get, "/locations/locationIdX/orders/orderIdX/delivery"],
    },
    create_delivery: {
      [{}, ["locationIdX", "orderIdX", { carrier: "UPS" }]] => [:post, "/locations/locationIdX/orders/orderIdX/delivery", { body: { carrier: "UPS" }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
    patch_delivery: {
      [{}, ["locationIdX", "orderIdX", { status: "delivered" }]] => [:patch, "/locations/locationIdX/orders/orderIdX/delivery", { body: { status: "delivered" }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
    get_callback: {
      [{}, []] => [:get, "/callback"],
    },
    get_callback_events: {
      [{}, []] => [:get, "/callback/events"],
    },
    delete_event: {
      [{}, ["eventIdX"]] => [:delete, "/callback/events/eventIdX"],
    },
    update_callback: {
      [{}, [{ "order" => ["create"] }]] => [:post, "/callback", { body: { order: ["create"] }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
    delete_callback: {
      [{}, []] => [:delete, "/callback"],
    },
    get_location_customer_lists: {
      [{}, ["locationIdX"]] => [:get, "/locations/locationIdX/customer_lists"],
    },
    get_account_customer_lists: {
      [{}, ["accountIdX"]] => [:get, "/accounts/accountIdX/customer_lists"],
    },
    get_customer_list: {
      [{}, ["customerListIdX"]] => [:get, "/customer_lists/customerListIdX"],
      [{ customer_list_id: "customerListIdX" }, []] => [:get, "/customer_lists/customerListIdX"],
    },
    get_all_customers: {
      [{}, ["customerListIdX"]] => [:get, "/customer_lists/customerListIdX/customers"],
      [{ customer_list_id: "customerListIdX" }, []] => [:get, "/customer_lists/customerListIdX/customers"],
    },
    search_customers: {
      [{ customer_list_id: "customerListIdX" }, [{ email: "nsave@*" }]] => [:get, "/customer_lists/customerListIdX/customers?email=nsave@*"],
      [{}, [{ email: "nsave@*" }, "customerListIdX"]] => [:get, "/customer_lists/customerListIdX/customers?email=nsave@*"],
    },
    get_customer: {
      [{ customer_list_id: "customerListIdX" }, ["customerIdX"]] => [:get, "/customer_lists/customerListIdX/customers/customerIdX"],
      [{}, ["customerIdX", "customerListIdX"]] => [:get, "/customer_lists/customerListIdX/customers/customerIdX"],
    },
    create_customer: {
      [{ customer_list_id: "customerListIdX" }, [{ first_name: "nsave" }]] => [:post, "/customer_lists/customerListIdX/customers", { body: { first_name: "nsave" }.to_json, headers: { "Content-Type" => "application/json" } }],
      [{}, [{ first_name: "nsave" }, "customerListIdX"]] => [:post, "/customer_lists/customerListIdX/customers", { body: { first_name: "nsave" }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
    update_customer: {
      [{ customer_list_id: "customerListIdX" }, ["customerIdX", { first_name: "nsave" }]] => [:put, "/customer_lists/customerListIdX/customers/customerIdX", { body: { first_name: "nsave" }.to_json, headers: { "Content-Type" => "application/json" } }],
      [{}, ["customerIdX", { first_name: "nsave" }, "customerListIdX"]] => [:put, "/customer_lists/customerListIdX/customers/customerIdX", { body: { first_name: "nsave" }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
    get_location_catalogs: {
      [{}, ["locationIdX"]] => [:get, "/locations/locationIdX/catalogs"],
    },
    get_account_catalogs: {
      [{}, ["accountIdX"]] => [:get, "/accounts/accountIdX/catalogs"],
    },
    get_catalog: {
      [{}, ["catalogIdX"]] => [:get, "/catalogs/catalogIdX"],
      [{}, ["catalogIdX", :hide_data]] => [:get, "/catalogs/catalogIdX?hide_data=true"],
      [{ catalog_id: "catalogIdX" }, []] => [:get, "/catalogs/catalogIdX"],
    },
    create_account_catalog: {
      [{}, [{ name: "Catalog1" }]] => [:post, "/account/catalogs", { body: { name: "Catalog1" }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
    create_location_catalog: {
      [{}, [{ name: "Catalog1" }, "locationIdX"]] => [:post, "/locations/locationIdX/catalogs", { body: { name: "Catalog1" }.to_json, headers: { "Content-Type" => "application/json" } }],
      [{}, [{ name: "Catalog1" }]] => [:post, "/location/catalogs", { body: { name: "Catalog1" }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
    update_catalog: {
      [{}, [{ name: "Catalog1" }, "catalogIdX"]] => [:put, "/catalogs/catalogIdX", { body: { name: "Catalog1" }.to_json, headers: { "Content-Type" => "application/json" } }],
      [{ catalog_id: "zrk6b" }, [{ name: "Catalog1" }]] => [:put, "/catalogs/zrk6b", { body: { name: "Catalog1" }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
    create_image: {
      [{}, ["bin1", "image/png", "catalogIdX"]] => [:post, "/catalogs/catalogIdX/images", { body: "bin1", headers: { "Content-Type" => "image/png" } }],
      [{ catalog_id: "zrk6b" }, ["bin1", "image/png"]] => [:post, "/catalogs/zrk6b/images", { body: "bin1", headers: { "Content-Type" => "image/png" } }],
    },
    get_images: {
      [{}, ["catalogIdX"]] => [:get, "/catalogs/catalogIdX/images"],
      [{ catalog_id: "zrk6b" }, []] => [:get, "/catalogs/zrk6b/images"],
    },
    get_image: {
      [{}, ["imageIdX", "catalogIdX"]] => [:get, "/catalogs/catalogIdX/images/imageIdX"],
      [{ catalog_id: "catalogIdX" }, ["imageIdX"]] => [:get, "/catalogs/catalogIdX/images/imageIdX"],
    },
    get_image_data: {
      [{}, ["imageIdX", "catalogIdX"]] => [:get, "/catalogs/catalogIdX/images/imageIdX/data"],
      [{ catalog_id: "catalogIdX" }, ["imageIdX"]] => [:get, "/catalogs/catalogIdX/images/imageIdX/data"],
    },
    get_inventory: {
      [{}, ["catalogIdX", "locationIdX"]] => [:get, "/catalogs/catalogIdX/locations/locationIdX/inventory"],
      [{}, ["catalogIdX"]] => [:get, "/catalogs/catalogIdX/location/inventory"],
      [{ catalog_id: "catalogIdX" }, []] => [:get, "/catalogs/catalogIdX/location/inventory"],
    },
    update_inventory: {
      [{}, [[{ sku_ref: "sku_refX" }], "catalogIdX", "locationIdX"]] => [:put, "/catalogs/catalogIdX/locations/locationIdX/inventory", { body: [{ sku_ref: "sku_refX" }].to_json, headers: { "Content-Type" => "application/json" } }],
      [{}, [[{ sku_ref: "sku_refX" }], "catalogIdX"]] => [:put, "/catalogs/catalogIdX/location/inventory", { body: [{ sku_ref: "sku_refX" }].to_json, headers: { "Content-Type" => "application/json" } }],
      [{ catalog_id: "catalogIdX" }, [[{ sku_ref: "sku_refX" }]]] => [:put, "/catalogs/catalogIdX/location/inventory", { body: [{ sku_ref: "sku_refX" }].to_json, headers: { "Content-Type" => "application/json" } }],
    },
    patch_inventory: {
      [{}, [[{ sku_ref: "sku_refX" }], "catalogIdX", "locationIdX"]] => [:patch, "/catalogs/catalogIdX/locations/locationIdX/inventory", { body: [{ sku_ref: "sku_refX" }].to_json, headers: { "Content-Type" => "application/json" } }],
      [{}, [[{ sku_ref: "sku_refX" }], "catalogIdX"]] => [:patch, "/catalogs/catalogIdX/location/inventory", { body: [{ sku_ref: "sku_refX" }].to_json, headers: { "Content-Type" => "application/json" } }],
      [{ catalog_id: "catalogIdX" }, [[{ sku_ref: "sku_refX" }]]] => [:patch, "/catalogs/catalogIdX/location/inventory", { body: [{ sku_ref: "sku_refX" }].to_json, headers: { "Content-Type" => "application/json" } }],
    },
    create_loyalty_card: {
      [{ customer_list_id: "customerListIdX" }, [{ name: "LC1" }]] => [:post, "/customer_lists/customerListIdX/loyalty_cards", { body: { name: "LC1" }.to_json, headers: { "Content-Type" => "application/json" } }],
      [{}, [{ name: "LC1" }, "customerListIdX"]] => [:post, "/customer_lists/customerListIdX/loyalty_cards", { body: { name: "LC1" }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
    create_loyalty_operation: {
      [{ customer_list_id: "customerListIdX" }, ["loyaltyCardIdX", { delta: "4.2" }]] => [:post, "/customer_lists/customerListIdX/loyalty_cards/loyaltyCardIdX/operations", { body: { delta: "4.2" }.to_json, headers: { "Content-Type" => "application/json" } }],
      [{}, ["loyaltyCardIdX", { delta: "4.2" }, "customerListIdX"]] => [:post, "/customer_lists/customerListIdX/loyalty_cards/loyaltyCardIdX/operations", { body: { delta: "4.2" }.to_json, headers: { "Content-Type" => "application/json" } }],
    },
  }.each do |method, examples|
    describe "### #{method.upcase}" do
      examples.each do |(init_args, method_args), (http_method, path, request_data)|
        init_args = { access_token: "access_token1" }.merge(init_args || {})

        human_args = method_args.map { |arg| arg.is_a?(String) ? arg.to_json : arg }.join(", ")
        request_data = { headers: { "X-Access-Token" => "access_token1" } }.merge(request_data || {})
        code_example = [
          "```",
          "HubriseClient::V1.new(client_attrs).#{method}(#{human_args})",
          "// => [#{http_method.upcase}] #{path} with #{request_data}",
          "```",
        ].join("\n      ")

        context "- Initialized with `client_attrs = #{init_args}`" do
          example code_example do
            stub = stub_request(http_method, "https://api.hubrise.com/v1" + path)
              .with(request_data)
              .to_return(status: 200, body: { key: "val" }.to_json)

            client = HubriseClient::V1.new(nil, nil, init_args)
            api_response = if method_args.any?
              kwargs = method_args.delete(:hide_data) ? { hide_data: true } : {}
              client.public_send(method, *method_args, **kwargs)
            else
              client.public_send(method)
            end

            expect(stub).to have_been_requested
            expect(api_response).to have_attributes(
              code: "200",
              failed: false,
              data: { "key" => "val" },
              error_type: nil,
              error_message: nil,
              errors: nil,
              http_response: an_instance_of(Net::HTTPOK)
            )
          end
        end
      end
    end
  end
end
