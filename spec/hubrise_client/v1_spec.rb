# frozen_string_literal: true
require "spec_helper"
describe HubriseClient::V1 do
  let(:client) { HubriseClient::V1.new("app_id1", "app_secret1", access_token: "access_token1") }

  describe "#build_authorization_url" do
    it "builds proper url" do
      url = client.build_authorization_url("redirect_uri.com", "profile", key1: :val1)
      expect(url).to eq("https://manager.hubrise.com:443/oauth2/v1/authorize?key1=val1&redirect_uri=redirect_uri.com&scope=profile&client_id=app_id1")
    end
  end

  describe "#authorize!" do
    subject { client.authorize!("CODE1") }

    it "exchanges a code for token" do
      stub_request(:post, "https://manager.hubrise.com/oauth2/v1/token")
        .with(
          body: {
            client_id: "app_id1",
            client_secret: "app_secret1",
            code: "CODE1",
          }.to_json
        ).to_return(
          status: 200,
          body: {
            access_token: "access_token1",
            app_instance_id: "app_instance_id1",
            user_id: "user_id1",
            account_id: "account_id1",
            location_id: "location_id1",
            catalog_id: "catalog_id1",
            customer_list_id: "customer_list_id1",
          }.to_json
        )

      subject
      expect(client).to have_attributes(
        access_token: "access_token1",
        app_instance_id: "app_instance_id1",
        user_id: "user_id1",
        account_id: "account_id1",
        location_id: "location_id1",
        catalog_id: "catalog_id1",
        customer_list_id: "customer_list_id1"
      )
    end

    it "raises InvalidHubriseGrantParams for wrong code" do
      stub_request(:post, "https://manager.hubrise.com/oauth2/v1/token").to_return(status: 404)
      expect { subject }.to raise_error(HubriseClient::InvalidHubriseGrantParams)
    end

    it "raises generic error for unexpected response" do
      stub_request(:post, "https://manager.hubrise.com/oauth2/v1/token").to_return(status: 500)
      expect { subject }.to raise_error(HubriseClient::HubriseError)
    end
  end

  describe "call_api" do
    subject { client.send(:call_api, "/some_path") }

    it "handles successful response" do
      stub_request(:get, "https://api.hubrise.com/v1/some_path").with(headers: { "X-Access-Token" => "access_token1" })
        .to_return(status: 200, body: { key1: :val1 }.to_json)

      expect(subject).to have_attributes(
        code: "200",
        failed: false,
        data: { "key1" => "val1" },
        error_type: nil,
        error_message: nil,
        errors: nil,
        http_response: an_instance_of(Net::HTTPOK)
      )
    end

    it "handles 429 response" do
      stub_request(:get, "https://api.hubrise.com/v1/some_path").with(headers: { "X-Access-Token" => "access_token1" })
        .to_return(status: 429, headers: { "retry-after": 100 })

      expect(subject).to have_attributes(
        code: "429",
        failed: true,
        data: "",
        error_type: nil,
        error_message: nil,
        errors: nil,
        http_response: an_instance_of(Net::HTTPTooManyRequests),
        retry_after: 100
      )
    end

    it "handles error response" do
      stub_request(:get, "https://api.hubrise.com/v1/some_path").with(headers: { "X-Access-Token" => "access_token1" })
        .to_return(status: 400, body: { "message" => "Validation failed", "errors" => [{ "field" => "field1", "message" => "is invalid" }], "error_type" => "unprocessable_entity" }.to_json)

      expect(subject).to have_attributes(
        code: "400",
        failed: true,
        data: { "message" => "Validation failed", "errors" => [{ "field" => "field1", "message" => "is invalid" }], "error_type" => "unprocessable_entity" },
        error_type: "unprocessable_entity",
        error_message: "Validation failed",
        errors: [{ "field" => "field1", "message" => "is invalid" }],
        http_response: an_instance_of(Net::HTTPBadRequest)
      )
    end

    it "raises for 401" do
      stub_request(:get, "https://api.hubrise.com/v1/some_path").with(headers: { "X-Access-Token" => "access_token1" })
        .to_return(status: 401)

      expect { subject }.to raise_error(HubriseClient::InvalidHubriseToken)
    end

    context "with callback" do
      it "calls callback for success" do
        stub_request(:get, "https://api.hubrise.com/v1/some_path").to_return(status: 200, body: { key1: :val1 }.to_json)

        called = false
        client.request_callback = lambda { |request, response|
          called = true
          expect(request.http_request.uri.to_s).to eq("https://api.hubrise.com/v1/some_path")
          expect(response.http_response.body).to eq({ key1: :val1 }.to_json)
        }

        subject

        expect(called).to be_truthy
      end

      it "calls callback wihtout response for network error" do
        stub_request(:get, "https://api.hubrise.com/v1/some_path").to_raise(Errno::ECONNREFUSED)

        called = false
        client.request_callback = lambda { |request, response|
          called = true
          expect(request.http_request.uri.to_s).to eq("https://api.hubrise.com/v1/some_path")
          expect(response).to be_nil
        }

        expect { subject }.to raise_error(HubriseClient::HubriseError)

        expect(called).to be_truthy
      end
    end

    describe "#next?" do
      it "is false if cursor-next header is empty" do
        stub_request(:get, "https://api.hubrise.com/v1/some_path")
          .to_return(status: 200, body: {}.to_json)

        expect(subject.next?).to eq(false)
      end

      it "is true if cursor-next header is present" do
        stub_request(:get, "https://api.hubrise.com/v1/some_path")
          .to_return(status: 200, body: {}.to_json, headers: { "X-Cursor-Next" => "someid" })

        expect(subject.next?).to eq(true)
      end
    end

    describe "#next_page" do
      it "makes a new request with a new cursor" do
        page1_body = { "page" => 1 }
        page2_body = { "page" => 2 }
        page3_body = { "page" => 3 }

        stub_request(:get, "https://api.hubrise.com/v1/some_path")
          .to_return(status: 200, body: page1_body.to_json, headers: { "X-Cursor-Next" => "someid1" })

        stub_request(:get, "https://api.hubrise.com/v1/some_path?cursor=someid1")
          .to_return(status: 200, body: page2_body.to_json, headers: { "X-Cursor-Next" => "someid2" })

        stub_request(:get, "https://api.hubrise.com/v1/some_path?cursor=someid2")
          .to_return(status: 200, body: page3_body.to_json)

        expect(subject.data).to eq(page1_body)

        response2 = subject.next_page
        expect(response2.data).to eq(page2_body)

        response3 = response2.next_page
        expect(response3.data).to eq(page3_body)
      end
    end

    it "appends count param" do
      stub = stub_request(:get, "https://api.hubrise.com/v1/some_path?count=100")

      client.send(:call_api, "/some_path", data: { count: 100 })

      expect(stub).to have_been_requested
    end
  end
end
