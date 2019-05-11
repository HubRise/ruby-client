require "spec_helper"

describe Hubrise::APIClients::V1 do
  let(:client)  { Hubrise::APIClients::V1.new(nil, nil, access_token: "access_token1") }

  let!(:api_request) do
    double(:api_request).tap do |api_request|
      allow(Hubrise::APIRequest).to receive(:new).with(
        hostname: "api.hubrise.com:433/v1", access_token: "access_token1", use_https: true, logger: an_instance_of(Logger)
      ).and_return(api_request)
    end
  end
  let(:api_response) { Hubrise::APIResponse.new(Net::HTTPResponse.new(1.0, 200, "OK")) }

  {
    get_account: {
      [{}, ["abc"]] => [:get, "/accounts/abc", {}],
      [{}, []] => [:get, "/account", {}],
    },
    get_accounts: {
      [{}, []] => [:get, "/accounts", {}]
    },
    get_user: {
      [{}, []] => [:get, "/user", {}]
    },
    get_locations: {
      [{}, []] => [:get, "/locations", {}]
    },
    get_location: {
      [{}, ["abc"]] => [:get, "/locations/abc", {}],
      [{}, []] => [:get, "/location", {}],
    },
    get_orders: {
      [{}, ["abc", { status: "new" }]] => [:get, "/locations/abc/orders", { status: "new" }]
    },
    get_order: {
      [{}, ["abc", "qwe"]] => [:get, "/locations/abc/orders/qwe", {}]
    },
    create_order: {
      [{}, ["abc", { status: "new" }]] => [:post, "/locations/abc/orders", { status: "new" }]
    },
    update_order: {
      [{}, ["abc", "qwe", { status: "delivered" }]] => [:put, "/locations/abc/orders/qwe", { status: "delivered" }]
    },
    get_callback: {
      [{}, []] => [:get, "/callback", {}]
    },
    get_callback_events: {
      [{}, []] => [:get, "/callback/events", {}]
    },
    delete_event: {
      [{}, ["abc"]] => [:delete, "/callback/events/abc", {}]
    },
    update_callback: {
      [{}, [{ 'order' => ['create'] }]] => [:post, "/callback", { 'order' => ['create'] }]
    },
    delete_callback: {
      [{}, []] => [:delete, "/callback", {}]
    },
    get_location_customer_lists: {
      [{}, ["abc"]] => [:get, "/locations/abc/customer_lists", {}]
    },
    get_account_customer_lists: {
      [{}, ["abc"]] => [:get, "/accounts/abc/customer_lists", {}]
    },
    get_customer_list: {
      [{}, ["abc"]] => [:get, "/customer_lists/abc", {}],
      [{ customer_list_id: "qwe" }, []] => [:get, "/customer_lists/qwe", {}]
    },
    get_all_customers: {
      [{}, ["abc"]] => [:get, "/customer_lists/abc/customers", {}],
      [{ customer_list_id: "qwe" }, []] => [:get, "/customer_lists/qwe/customers", {}]
    },
    search_customers: {
      [{ customer_list_id: "abc" }, [{ email: "nsave@*" }]] => [:get, "/customer_lists/abc/customers", { email: "nsave@*" }],
      [{}, [{ email: "nsave@*" }, "qwe"]] => [:get, "/customer_lists/qwe/customers", { email: "nsave@*" }]
    },
    get_customer: {
      [{ customer_list_id: "abc" }, ["zxc"]] => [:get, "/customer_lists/abc/customers/zxc", {}],
      [{}, ["zxc", "qwe"]] => [:get, "/customer_lists/qwe/customers/zxc", {}]
    },
    create_customer: {
      [{ customer_list_id: "abc" }, [{ first_name: "nsave" }]] => [:post, "/customer_lists/abc/customers", { first_name: "nsave" }],
      [{}, [{ first_name: "nsave" }, "qwe"]] => [:post, "/customer_lists/qwe/customers", { first_name: "nsave" }]
    },
    update_customer: {
      [{ customer_list_id: "abc" }, ["zxc", { first_name: "nsave" }]] => [:put, "/customer_lists/abc/customers/zxc", { first_name: "nsave" }],
      [{}, ["zxc", { first_name: "nsave" }, "qwe"]] => [:put, "/customer_lists/qwe/customers/zxc", { first_name: "nsave" }]
    },
    get_location_catalogs: {
      [{},["abc"]] => [:get, "/locations/abc/catalogs", {}]
    },
    get_account_catalogs: {
      [{}, ["abc"]] => [:get, "/accounts/abc/catalogs", {}]
    },
    get_catalog: {
      [{}, ["abc"]] => [:get, "/catalogs/abc", {}],
      [{ catalog_id: "qwe" }, []] => [:get, "/catalogs/qwe", {}]
    },
    create_account_catalog: {
      [{}, [{ name: "Catalog1" }]] => [:post, "/account/catalogs", { name: "Catalog1" }]
    },
    create_location_catalog: {
      [{}, [{ name: "Catalog1" }, "abc"]] => [:post, "/locations/abc/catalogs", { name: "Catalog1" }],
      [{}, [{ name: "Catalog1" }]] => [:post, "/location/catalogs", { name: "Catalog1" }]
    },
    update_catalog: {
      [{}, [{ name: "Catalog1" }, "abc"]] => [:put, "/catalogs/abc", { name: "Catalog1" }],
      [{ catalog_id: "zxc" }, [{ name: "Catalog1" }]] => [:put, "/catalogs/zxc", { name: "Catalog1" }]
    },
    create_image: {
      [{}, ["bin1", "image/png", "abc"]] => [:post, "/catalogs/abc/images", "bin1", { json: false, headers: { "Content-Type" => "image/png" } }],
      [{ catalog_id: "zxc" }, ["bin1", "image/png"]] => [:post, "/catalogs/zxc/images", "bin1", { json: false, headers: { "Content-Type" => "image/png" } }]
    },
    get_image: {
      [{}, ["abc", "qwe"]] => [:get, "/catalogs/qwe/images/abc", {}],
      [{ catalog_id: "zxc" }, ["abc"]] => [:get, "/catalogs/zxc/images/abc", {}],
    },
    get_image_data: {
      [{}, ["abc", "qwe"]] => [:get, "/catalogs/qwe/images/abc/data", {}],
      [{ catalog_id: "zxc" }, ["abc"]] => [:get, "/catalogs/zxc/images/abc/data", {}],
    }
  }.each do |method, examples|
    describe "#{method.upcase}" do
      examples.each do |(init_args, method_args), api_request_args|
        context "initialized with #{init_args}" do
          human_args = method_args.map { |arg| arg.is_a?(String) ? arg.to_json : arg }.join(', ')

          example "##{method}(#{human_args}) queries #{api_request_args}" do
            client = Hubrise::APIClients::V1.new(nil, nil, { access_token: "access_token1" }.merge(init_args))

            api_request_args[3] = { json: true, headers: {} }.merge(api_request_args[3] || {})
            expect(api_request).to receive(:perform).with(*api_request_args).and_return(:some_response)

            expect(
              if method_args.any?
                client.public_send(method, *method_args)
              else
                client.public_send(method)
              end
            ).to eq(:some_response)
          end
        end
      end 
    end
  end
end
