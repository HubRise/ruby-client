require "spec_helper"

# rubocop:disable Metrics/LineLength, Metrics/BlockLength
describe HubriseClient::V1 do
  let(:client) { HubriseClient::V1.new("app_id1", "app_secret1", access_token: "access_token1") }

  describe "#build_authorization_url" do
    it "builds proper url" do
      url = client.build_authorization_url("redirect_uri.com", "profile", key1: :val1)
      expect(url).to eq("https://manager.hubrise.com:433/oauth2/v1/authorize?key1=val1&redirect_uri=redirect_uri.com&scope=profile&client_id=app_id1")
    end
  end

  describe "#authorize!" do
    subject { client.authorize!("CODE1") }

    it "exchanges a code for token" do
      stub_request(:post, "https://manager.hubrise.com:433/oauth2/v1/token")
        .with(
          body: {
            client_id: "app_id1",
            client_secret: "app_secret1",
            code: "CODE1"
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
            customer_list_id: "customer_list_id1"
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
      stub_request(:post, "https://manager.hubrise.com:433/oauth2/v1/token").to_return(status: 404)
      expect { subject }.to raise_error(HubriseClient::InvalidHubriseGrantParams)
    end

    it "raises generic error for unexpected response" do
      stub_request(:post, "https://manager.hubrise.com:433/oauth2/v1/token").to_return(status: 500)
      expect { subject }.to raise_error(HubriseClient::HubriseError)
    end
  end

  describe "call_api" do
    subject { client.send(:call_api, "/some_path") }

    it "handles successful response" do
      stub_request(:get, "https://api.hubrise.com:433/v1/some_path").with(headers: { "X-Access-Token" => "access_token1" })
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
      stub_request(:get, "https://api.hubrise.com:433/v1/some_path").with(headers: { "X-Access-Token" => "access_token1" })
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
      stub_request(:get, "https://api.hubrise.com:433/v1/some_path").with(headers: { "X-Access-Token" => "access_token1" })
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
  end
end
