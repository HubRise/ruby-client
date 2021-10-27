# Full list of available methods to access the API

```ruby
client = HubriseClient::V1.new(CLIENT_ID, CLIENT_SECRET, client_attrs)
```

### GET_ACCOUNT

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_account("zrn61")
  # [GET] /accounts/zrn61 with { headers: { "X-Access-Token": "access_token1" }}
  ```
- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_account
  # [GET] /account with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_ACCOUNTS

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_accounts
  # [GET] /accounts with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_USER

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_user
  # [GET] /user with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_LOCATIONS

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_locations
  # [GET] /locations with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_LOCATION

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_location("zrn61")
  # [GET] /locations/zrn61 with { headers: { "X-Access-Token": "access_token1" }}
  ```
- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_location
  # [GET] /location with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_ORDERS

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_orders("zrn61", { status: "new" })
  # [GET] /locations/zrn61/orders?status=new with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_ORDER

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_order("zrn61", "wy3xz")
  # [GET] /locations/zrn61/orders/wy3xz with { headers: { "X-Access-Token": "access_token1" }}
  ```

### CREATE_ORDER

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.create_order("zrn61", { status: "new" })
  # [POST] /locations/zrn61/orders with { headers: { "Content-Type": "application/json" }, body: "{\"status\":\"new\" }" }
  ```

### UPDATE_ORDER

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.update_order("zrn61", "wy3xz", { status: "delivered" })
  # [PUT] /locations/zrn61/orders/wy3xz with { headers: { "Content-Type": "application/json" }, body: "{\"status\":\"delivered\" }" }
  ```

### GET_CALLBACK

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_callback
  # [GET] /callback with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_CALLBACK_EVENTS

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_callback_events
  # [GET] /callback/events with { headers: { "X-Access-Token": "access_token1" }}
  ```

### DELETE_EVENT

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.delete_event("zrn61")
  # [DELETE] /callback/events/zrn61 with { headers: { "X-Access-Token": "access_token1" }}
  ```

### UPDATE_CALLBACK

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.update_callback({ "order": ["create"]})
  # [POST] /callback with { headers: { "Content-Type": "application/json" }, body: "{\"order\":[\"create\"]}" }
  ```

### DELETE_CALLBACK

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.delete_callback
  # [DELETE] /callback with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_LOCATION_CUSTOMER_LISTS

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_location_customer_lists("zrn61")
  # [GET] /locations/zrn61/customer_lists with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_ACCOUNT_CUSTOMER_LISTS

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_account_customer_lists("zrn61")
  # [GET] /accounts/zrn61/customer_lists with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_CUSTOMER_LIST

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_customer_list("zrn61")
  # [GET] /customer_lists/zrn61 with { headers: { "X-Access-Token": "access_token1" }}
  ```
- Initialized with `client_attrs = { access_token: "access_token1", customer_list_id: "wy3xz" }`
  ```ruby
  client.get_customer_list
  # [GET] /customer_lists/wy3xz with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_ALL_CUSTOMERS

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_all_customers("zrn61")
  # [GET] /customer_lists/zrn61/customers with { headers: { "X-Access-Token": "access_token1" }}
  ```
- Initialized with `client_attrs = { access_token: "access_token1", customer_list_id: "wy3xz" }`
  ```ruby
  client.get_all_customers
  # [GET] /customer_lists/wy3xz/customers with { headers: { "X-Access-Token": "access_token1" }}
  ```

### SEARCH_CUSTOMERS

- Initialized with `client_attrs = { access_token: "access_token1", customer_list_id: "zrn61" }`
  ```ruby
  client.search_customers({ email: "nsave@*" })
  # [GET] /customer_lists/zrn61/customers?email=nsave@* with { headers: { "X-Access-Token": "access_token1" }}
  ```
- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.search_customers({ email: "nsave@*" }, "wy3xz")
  # [GET] /customer_lists/wy3xz/customers?email=nsave@* with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_CUSTOMER

- Initialized with `client_attrs = { access_token: "access_token1", customer_list_id: "zrn61" }`
  ```ruby
  client.get_customer("zrk6b")
  # [GET] /customer_lists/zrn61/customers/zrk6b with { headers: { "X-Access-Token": "access_token1" }}
  ```
- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_customer("zrk6b", "wy3xz")
  # [GET] /customer_lists/wy3xz/customers/zrk6b with { headers: { "X-Access-Token": "access_token1" }}
  ```

### CREATE_CUSTOMER

- Initialized with `client_attrs = { access_token: "access_token1", customer_list_id: "zrn61" }`
  ```ruby
  client.create_customer({ first_name: "nsave" })
  # [POST] /customer_lists/zrn61/customers with { headers: { "Content-Type": "application/json" }, body: "{\"first_name\":\"nsave\" }" }
  ```
- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.create_customer({ first_name: "nsave" }, "wy3xz")
  # [POST] /customer_lists/wy3xz/customers with { headers: { "Content-Type": "application/json" }, body: "{\"first_name\":\"nsave\" }" }
  ```

### UPDATE_CUSTOMER

- Initialized with `client_attrs = { access_token: "access_token1", customer_list_id: "zrn61" }`
  ```ruby
  client.update_customer("zrk6b", { first_name: "nsave" })
  # [PUT] /customer_lists/zrn61/customers/zrk6b with { headers: { "Content-Type": "application/json" }, body: "{\"first_name\":\"nsave\" }" }
  ```
- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.update_customer("zrk6b", { first_name: "nsave" }, "wy3xz")
  # [PUT] /customer_lists/wy3xz/customers/zrk6b with { headers: { "Content-Type": "application/json" }, body: "{\"first_name\":\"nsave\" }" }
  ```

### GET_LOCATION_CATALOGS

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_location_catalogs("zrn61")
  # [GET] /locations/zrn61/catalogs with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_ACCOUNT_CATALOGS

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_account_catalogs("zrn61")
  # [GET] /accounts/zrn61/catalogs with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_CATALOG

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_catalog("zrn61")
  # [GET] /catalogs/zrn61 with { headers: { "X-Access-Token": "access_token1" }}
  ```
- Initialized with `client_attrs = { access_token: "access_token1", catalog_id: "wy3xz" }`
  ```ruby
  client.get_catalog
  # [GET] /catalogs/wy3xz with { headers: { "X-Access-Token": "access_token1" }}
  ```

### CREATE_ACCOUNT_CATALOG

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.create_account_catalog({ name: "Catalog1" })
  # [POST] /account/catalogs with { headers: { "Content-Type": "application/json" }, body: "{\"name\":\"Catalog1\" }" }
  ```

### CREATE_LOCATION_CATALOG

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.create_location_catalog({ name: "Catalog1" }, "zrn61")
  # [POST] /locations/zrn61/catalogs with { headers: { "Content-Type": "application/json" }, body: "{\"name\":\"Catalog1\" }" }
  ```
- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.create_location_catalog({ name: "Catalog1" })
  # [POST] /location/catalogs with { headers: { "Content-Type": "application/json" }, body: "{\"name\":\"Catalog1\" }" }
  ```

### UPDATE_CATALOG

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.update_catalog({ name: "Catalog1" }, "zrn61")
  # [PUT] /catalogs/zrn61 with { headers: { "Content-Type": "application/json" }, body: "{\"name\":\"Catalog1\" }" }
  ```
- Initialized with `client_attrs = { access_token: "access_token1", catalog_id: "zrk6b" }`
  ```ruby
  client.update_catalog({ name: "Catalog1" })
  # [PUT] /catalogs/zrk6b with { headers: { "Content-Type": "application/json" }, body: "{\"name\":\"Catalog1\" }" }
  ```

### CREATE_IMAGE

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.create_image("bin1", "image/png", "zrn61")
  # [POST] /catalogs/zrn61/images with { headers: { "Content-Type": "image/png" }, body: "bin1" }
  ```
- Initialized with `client_attrs = { access_token: "access_token1", catalog_id: "zrk6b" }`
  ```ruby
  client.create_image("bin1", "image/png")
  # [POST] /catalogs/zrk6b/images with { headers: { "Content-Type": "image/png" }, body: "bin1" }
  ```

### GET_IMAGE

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_image("zrn61", "wy3xz")
  # [GET] /catalogs/wy3xz/images/zrn61 with { headers: { "X-Access-Token": "access_token1" }}
  ```
- Initialized with `client_attrs = { access_token: "access_token1", catalog_id: "zrk6b" }`
  ```ruby
  client.get_image("zrn61")
  # [GET] /catalogs/zrk6b/images/zrn61 with { headers: { "X-Access-Token": "access_token1" }}
  ```

### GET_IMAGE_DATA

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.get_image_data("zrn61", "wy3xz")
  # [GET] /catalogs/wy3xz/images/zrn61/data with { headers: { "X-Access-Token": "access_token1" }}
  ```
- Initialized with `client_attrs = { access_token: "access_token1", catalog_id: "zrk6b" }`
  ```ruby
  client.get_image_data("zrn61")
  # [GET] /catalogs/zrk6b/images/zrn61/data with { headers: { "X-Access-Token": "access_token1" }}
  ```

### CREATE_LOYALTY_CARD

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.create_loyalty_card({ name: "bonus" }, "wy3xz")
  # [POST] /customer_lists/wy3xz/loyalty_cards with { headers: { "X-Access-Token": "access_token1" }, body: { name: "bonus" } }
  ```
- Initialized with `client_attrs = { access_token: "access_token1", customer_list_id: "zrk6b" }`
  ```ruby
  client.create_loyalty_card({ name: "bonus" })
  # [POST] /customer_lists/zrk6b/loyalty_cards with { headers: { "X-Access-Token": "access_token1" }, body: { name: "bonus" } }
  ```

### CREATE_LOYALTY_OPERATION

- Initialized with `client_attrs = { access_token: "access_token1" }`
  ```ruby
  client.create_loyalty_operation("zrk6b", { delta: "4.2" }, "wy3xz")
  # [POST] /customer_lists/wy3xz/loyalty_cards/zrk6b/operations with { headers: { "X-Access-Token": "access_token1" }, body: { delta: "4.2" } }
  ```
- Initialized with `client_attrs = { access_token: "access_token1", customer_list_id: "q2brk" }`
  ```ruby
  client.create_loyalty_operation("zrk6b", { delta: "4.2" })
  # [POST] /customer_lists/q2brk/loyalty_cards/zrk6b/operations with { headers: { "X-Access-Token": "access_token1" }, body: { delta: "4.2" } }
  ```
