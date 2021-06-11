This gem is a thin wrapper for [Hubrise API](https://www.hubrise.com/developers)

# Installation

Add `hubrise_client` to your `Gemfile`:

```ruby
gem 'hubrise_client'
```

Or install via [gem](http://rubygems.org/)

```bash
gem install hubrise_client
```


# Prerequisites

1) Read the [docs](https://www.hubrise.com/developers)

2) [Create a Hubrise Client](https://www.hubrise.com/developers/quick-start#create-the-oauth-client) to get your `CLIENT_ID` and `CLIENT_SECRET`.


# Get an access token

1. Initialize anonymous `HubriseClient`
    ```ruby
    client = HubriseClient::V1.new(CLIENT_ID, CLIENT_SECRET)
    ```

2. Prepare a route to handle `REDIRECT_URI` callback
    ```ruby
    # routes.rb
    namespace :hubrise_oauth do
      get :authorize_callback
      # => creates hubrise_oauth_authorize_callback_url helper
    end
    ```
  

3. Initiate an OAuth flow by redirecting a user to [OAuth Authorization URL](https://www.hubrise.com/developers/authentication#request-authorisation)
    ```ruby
    oauth_scope = "location[orders.read]" # adjust to your needs
    authorization_url = client.build_authorization_url(hubrise_oauth_authorize_callback_url, oauth_scope)
    ...
    redirect_to(authorization_url)
    ```

4. Complete the OAuth flow

    Once the user accepts your request he or she will be redirected to the REDIRECT_URI
    At this step you need to [exchange](https://www.hubrise.com/developers/authentication#get-an-access-token) the `authorization_code` (received as a query param) for a new `access_token`


    ```ruby
    # controllers/hubrise_oauth_controller.rb

    def authorize_callback
      client.authorize!(params[:code])

      current_user.update!(hubrise_access_token: client.access_token)
      # account_id = client.account_id
      # location_id = client.location_id
    end
    ```

    The `access_token` reffers to this specific user's permission so it should be securely persisted and not shared with other users.


# Use the access token

```ruby
client = HubriseClient::V1.new(CLIENT_ID, CLIENT_SECRET, access_token: current_user.hubrise_access_token)
```

Now you can call the [helper methods](https://github.com/HubRise/ruby-client/blob/master/V1_ENDPOINTS.md) on behalf of the user
```ruby
client.get_account
```
