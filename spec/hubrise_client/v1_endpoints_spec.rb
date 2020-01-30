require "spec_helper"

# rubocop:disable Metrics/LineLength, Metrics/BlockLength
describe HubriseClient::V1 do
  let(:client) { HubriseClient::V1.new(nil, nil, access_token: "access_token1") }

  {
    get_account: {
      [{}, ["zrn61"]] => [:get, "/accounts/zrn61"],
      [{}, []] => [:get, "/account"]
    },
    get_accounts: {
      [{}, []] => [:get, "/accounts"]
    },
    get_user: {
      [{}, []] => [:get, "/user"]
    },
    get_locations: {
      [{}, []] => [:get, "/locations"]
    },
    get_location: {
      [{}, ["zrn61"]] => [:get, "/locations/zrn61"],
      [{}, []] => [:get, "/location"]
    },
    get_orders: {
      [{}, ["zrn61", { status: "new" }]] => [:get, "/locations/zrn61/orders?status=new"]
    },
    get_order: {
      [{}, ["zrn61", "wy3xz"]] => [:get, "/locations/zrn61/orders/wy3xz"]
    },
    create_order: {
      [{}, ["zrn61", { status: "new" }]] => [:post, "/locations/zrn61/orders", { body: { status: "new" }.to_json, headers: { "Content-Type" => "application/json" } }]
    },
    update_order: {
      [{}, ["zrn61", "wy3xz", { status: "delivered" }]] => [:put, "/locations/zrn61/orders/wy3xz", { body: { status: "delivered" }.to_json, headers: { "Content-Type" => "application/json" } }]
    },
    get_callback: {
      [{}, []] => [:get, "/callback"]
    },
    get_callback_events: {
      [{}, []] => [:get, "/callback/events"]
    },
    delete_event: {
      [{}, ["zrn61"]] => [:delete, "/callback/events/zrn61"]
    },
    update_callback: {
      [{}, [{ "order" => ["create"] }]] => [:post, "/callback", { body: { order: ["create"] }.to_json, headers: { "Content-Type" => "application/json" } }]
    },
    delete_callback: {
      [{}, []] => [:delete, "/callback"]
    },
    get_location_customer_lists: {
      [{}, ["zrn61"]] => [:get, "/locations/zrn61/customer_lists"]
    },
    get_account_customer_lists: {
      [{}, ["zrn61"]] => [:get, "/accounts/zrn61/customer_lists"]
    },
    get_customer_list: {
      [{}, ["zrn61"]] => [:get, "/customer_lists/zrn61"],
      [{ customer_list_id: "wy3xz" }, []] => [:get, "/customer_lists/wy3xz"]
    },
    get_all_customers: {
      [{}, ["zrn61"]] => [:get, "/customer_lists/zrn61/customers"],
      [{ customer_list_id: "wy3xz" }, []] => [:get, "/customer_lists/wy3xz/customers"]
    },
    search_customers: {
      [{ customer_list_id: "zrn61" }, [{ email: "nsave@*" }]] => [:get, "/customer_lists/zrn61/customers?email=nsave@*"],
      [{}, [{ email: "nsave@*" }, "wy3xz"]] => [:get, "/customer_lists/wy3xz/customers?email=nsave@*"]
    },
    get_customer: {
      [{ customer_list_id: "zrn61" }, ["zrk6b"]] => [:get, "/customer_lists/zrn61/customers/zrk6b"],
      [{}, ["zrk6b", "wy3xz"]] => [:get, "/customer_lists/wy3xz/customers/zrk6b"]
    },
    create_customer: {
      [{ customer_list_id: "zrn61" }, [{ first_name: "nsave" }]] => [:post, "/customer_lists/zrn61/customers", { body: { first_name: "nsave" }.to_json, headers: { "Content-Type" => "application/json" } }],
      [{}, [{ first_name: "nsave" }, "wy3xz"]] => [:post, "/customer_lists/wy3xz/customers", { body: { first_name: "nsave" }.to_json, headers: { "Content-Type" => "application/json" } }]
    },
    update_customer: {
      [{ customer_list_id: "zrn61" }, ["zrk6b", { first_name: "nsave" }]] => [:put, "/customer_lists/zrn61/customers/zrk6b", { body: { first_name: "nsave" }.to_json, headers: { "Content-Type" => "application/json" } }],
      [{}, ["zrk6b", { first_name: "nsave" }, "wy3xz"]] => [:put, "/customer_lists/wy3xz/customers/zrk6b", { body: { first_name: "nsave" }.to_json, headers: { "Content-Type" => "application/json" } }]
    },
    get_location_catalogs: {
      [{}, ["zrn61"]] => [:get, "/locations/zrn61/catalogs"]
    },
    get_account_catalogs: {
      [{}, ["zrn61"]] => [:get, "/accounts/zrn61/catalogs"]
    },
    get_catalog: {
      [{}, ["zrn61"]] => [:get, "/catalogs/zrn61"],
      [{ catalog_id: "wy3xz" }, []] => [:get, "/catalogs/wy3xz"]
    },
    create_account_catalog: {
      [{}, [{ name: "Catalog1" }]] => [:post, "/account/catalogs", { body: { name: "Catalog1" }.to_json, headers: { "Content-Type" => "application/json" } }]
    },
    create_location_catalog: {
      [{}, [{ name: "Catalog1" }, "zrn61"]] => [:post, "/locations/zrn61/catalogs", { body: { name: "Catalog1" }.to_json, headers: { "Content-Type" => "application/json" } }],
      [{}, [{ name: "Catalog1" }]] => [:post, "/location/catalogs", { body: { name: "Catalog1" }.to_json, headers: { "Content-Type" => "application/json" } }]
    },
    update_catalog: {
      [{}, [{ name: "Catalog1" }, "zrn61"]] => [:put, "/catalogs/zrn61", { body: { name: "Catalog1" }.to_json, headers: { "Content-Type" => "application/json" } }],
      [{ catalog_id: "zrk6b" }, [{ name: "Catalog1" }]] => [:put, "/catalogs/zrk6b", { body: { name: "Catalog1" }.to_json, headers: { "Content-Type" => "application/json" } }]
    },
    create_image: {
      [{}, ["bin1", "image/png", "zrn61"]] => [:post, "/catalogs/zrn61/images", { body: "bin1", headers: { "Content-Type" => "image/png" } }],
      [{ catalog_id: "zrk6b" }, ["bin1", "image/png"]] => [:post, "/catalogs/zrk6b/images", { body: "bin1", headers: { "Content-Type" => "image/png" } }]
    },
    get_image: {
      [{}, ["zrn61", "wy3xz"]] => [:get, "/catalogs/wy3xz/images/zrn61"],
      [{ catalog_id: "zrk6b" }, ["zrn61"]] => [:get, "/catalogs/zrk6b/images/zrn61"]
    },
    get_image_data: {
      [{}, ["zrn61", "wy3xz"]] => [:get, "/catalogs/wy3xz/images/zrn61/data"],
      [{ catalog_id: "zrk6b" }, ["zrn61"]] => [:get, "/catalogs/zrk6b/images/zrn61/data"]
    }
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
          "```"
        ].join("\n      ")

        context "- Initialized with `client_attrs = #{init_args}`" do
          example code_example do
            stub = stub_request(http_method, "https://api.hubrise.com/v1" + path)
                   .with(request_data)
                   .to_return(status: 200, body: { key: "val" }.to_json)

            client = HubriseClient::V1.new(nil, nil, init_args)
            api_response = if method_args.any?
                             client.public_send(method, *method_args)
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
