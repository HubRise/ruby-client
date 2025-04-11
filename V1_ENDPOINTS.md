# Full list of available methods to access the API

```ruby
client = HubriseClient::V1.new(CLIENT_ID, CLIENT_SECRET, client_attrs)
```

### GET_ACCOUNT

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_account("accountIdX")
  # [GET] /accounts/accountIdX with { headers: { "X-Access-Token": "accessTokenX" }}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_account
  # [GET] /account with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_ACCOUNTS

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_accounts
  # [GET] /accounts with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_USER

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_user
  # [GET] /user with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_LOCATIONS

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_locations
  # [GET] /locations with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_LOCATION

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_location("locationIdX")
  # [GET] /locations/locationIdX with { headers: { "X-Access-Token": "accessTokenX" }}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_location
  # [GET] /location with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_ORDERS

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_orders("locationIdX", { status: "new" })
  # [GET] /locations/locationIdX/orders?status=new with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_ORDER

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_order("locationIdX", "orderIdX")
  # [GET] /locations/locationIdX/orders/orderIdX with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### CREATE_ORDER

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.create_order("locationIdX", { status: "new" })
  # [POST] /locations/locationIdX/orders with { headers: { "Content-Type": "application/json" }, body: "{\"status\":\"new\" }" }
  ```

### UPDATE_ORDER

- This method is deprecated. Use `PATCH_ORDER` instead.
- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.update_order("locationIdX", "orderIdX", { status: "delivered" })
  # [PUT] /locations/locationIdX/orders/orderIdX with { headers: { "Content-Type": "application/json" }, body: "{\"status\":\"delivered\" }" }
  ```

### PATCH_ORDER

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.patch_order("locationIdX", "orderIdX", { status: "delivered" })
  # [PATCH] /locations/locationIdX/orders/orderIdX with { headers: { "Content-Type": "application/json" }, body: "{\"status\":\"delivered\" }" }
  ```

### GET_DELIVERY

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_delivery("locationIdX", "orderIdX")
  # [GET] /locations/locationIdX/orders/orderIdX/delivery with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### CREATE_DELIVERY

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.create_delivery("locationIdX", "orderIdX", { carrier: "UPS" })
  # [POST] /locations/locationIdX/orders/orderIdX/delivery with { headers: { "Content-Type": "application/json" }, body: "{\"carrier\":\"UPS\" }" }
  ```

### PATCH_DELIVERY

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.patch_delivery("locationIdX", "orderIdX", { status: "delivered" })
  # [PATCH] /locations/locationIdX/orders/orderIdX/delivery with { headers: { "Content-Type": "application/json" }, body: "{\"status\":\"delivered\" }" }
  ```

### GET_CALLBACK

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_callback
  # [GET] /callback with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_CALLBACK_EVENTS

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_callback_events
  # [GET] /callback/events with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### DELETE_EVENT

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.delete_event("eventIdX")
  # [DELETE] /callback/events/eventIdX with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### UPDATE_CALLBACK

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.update_callback({ "order": ["create"]})
  # [POST] /callback with { headers: { "Content-Type": "application/json" }, body: "{\"order\":[\"create\"]}" }
  ```

### DELETE_CALLBACK

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.delete_callback
  # [DELETE] /callback with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_LOCATION_CUSTOMER_LISTS

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_location_customer_lists("locationIdX")
  # [GET] /locations/locationIdX/customer_lists with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_ACCOUNT_CUSTOMER_LISTS

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_account_customer_lists("accountIdX")
  # [GET] /accounts/accountIdX/customer_lists with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_CUSTOMER_LIST

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_customer_list("customerListIdX")
  # [GET] /customer_lists/customerListIdX with { headers: { "X-Access-Token": "accessTokenX" }}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX", customer_list_id: "customerListIdX" }`
  ```ruby
  client.get_customer_list
  # [GET] /customer_lists/customerListIdX with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_ALL_CUSTOMERS

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_all_customers("customerListIdX")
  # [GET] /customer_lists/customerListIdX/customers with { headers: { "X-Access-Token": "accessTokenX" }}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX", customer_list_id: "customerListIdX" }`
  ```ruby
  client.get_all_customers
  # [GET] /customer_lists/customerListIdX/customers with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### SEARCH_CUSTOMERS

- Initialized with `client_attrs = { access_token: "accessTokenX", customer_list_id: "customerListIdX" }`
  ```ruby
  client.search_customers({ email: "john@*" })
  # [GET] /customer_lists/customerListIdX/customers?email=john@* with { headers: { "X-Access-Token": "accessTokenX" }}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.search_customers({ email: "john@*" }, "customerListIdX")
  # [GET] /customer_lists/customerListIdX/customers?email=john@* with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_CUSTOMER

- Initialized with `client_attrs = { access_token: "accessTokenX", customer_list_id: "customerListIdX" }`
  ```ruby
  client.get_customer("customerIdX")
  # [GET] /customer_lists/customerListIdX/customers/customerIdX with { headers: { "X-Access-Token": "accessTokenX" }}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_customer("customerIdX", "customerListIdX")
  # [GET] /customer_lists/customerListIdX/customers/customerIdX with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### CREATE_CUSTOMER

- Initialized with `client_attrs = { access_token: "accessTokenX", customer_list_id: "customerListIdX" }`
  ```ruby
  client.create_customer({ first_name: "John" })
  # [POST] /customer_lists/customerListIdX/customers with { headers: { "Content-Type": "application/json" }, body: "{\"first_name\":\"John\" }" }
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.create_customer({ first_name: "John" }, "customerListIdX")
  # [POST] /customer_lists/customerListIdX/customers with { headers: { "Content-Type": "application/json" }, body: "{\"first_name\":\"John\" }" }
  ```

### UPDATE_CUSTOMER

- Initialized with `client_attrs = { access_token: "accessTokenX", customer_list_id: "customerListIdX" }`
  ```ruby
  client.update_customer("customerIdX", { first_name: "John" })
  # [PUT] /customer_lists/customerListIdX/customers/customerIdX with { headers: { "Content-Type": "application/json" }, body: "{\"first_name\":\"John\" }" }
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.update_customer("customerIdX", { first_name: "John" }, "customerListIdX")
  # [PUT] /customer_lists/customerListIdX/customers/customerIdX with { headers: { "Content-Type": "application/json" }, body: "{\"first_name\":\"John\" }" }
  ```

### GET_LOCATION_CATALOGS

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_location_catalogs("locationIdX")
  # [GET] /locations/locationIdX/catalogs with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_ACCOUNT_CATALOGS

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_account_catalogs("accountIdX")
  # [GET] /accounts/accountIdX/catalogs with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_CATALOG

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_catalog("catalogIdX")
  # [GET] /catalogs/catalogIdX with { headers: { "X-Access-Token": "accessTokenX" }}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX", catalog_id: "catalogIdX" }`
  ```ruby
  client.get_catalog
  # [GET] /catalogs/catalogIdX with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### CREATE_ACCOUNT_CATALOG

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.create_account_catalog({ name: "Catalog1" })
  # [POST] /account/catalogs with { headers: { "Content-Type": "application/json" }, body: "{\"name\":\"Catalog1\" }" }
  ```

### CREATE_LOCATION_CATALOG

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.create_location_catalog({ name: "Catalog1" }, "locationIdX")
  # [POST] /locations/locationIdX/catalogs with { headers: { "Content-Type": "application/json" }, body: "{\"name\":\"Catalog1\" }" }
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.create_location_catalog({ name: "Catalog1" })
  # [POST] /location/catalogs with { headers: { "Content-Type": "application/json" }, body: "{\"name\":\"Catalog1\" }" }
  ```

### UPDATE_CATALOG

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.update_catalog({ name: "Catalog1" }, "catalogIdX")
  # [PUT] /catalogs/catalogIdX with { headers: { "Content-Type": "application/json" }, body: "{\"name\":\"Catalog1\" }" }
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX", catalog_id: "catalogIdX" }`
  ```ruby
  client.update_catalog({ name: "Catalog1" })
  # [PUT] /catalogs/catalogIdX with { headers: { "Content-Type": "application/json" }, body: "{\"name\":\"Catalog1\" }" }
  ```

### CREATE_IMAGE

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.create_image("bin1", "image/png", "catalogIdX")
  # [POST] /catalogs/catalogIdX/images with { headers: { "Content-Type": "image/png" }, body: "bin1" }
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX", catalog_id: "catalogIdX" }`
  ```ruby
  client.create_image("bin1", "image/png")
  # [POST] /catalogs/catalogIdX/images with { headers: { "Content-Type": "image/png" }, body: "bin1" }
  ```

### GET_IMAGES

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_images("orderIdX")
  # [GET] /catalogs/orderIdX/images with { headers: { "X-Access-Token": "accessTokenX" }}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX", catalog_id: "catalogIdX" }`
  ```ruby
  client.get_images
  # [GET] /catalogs/catalogIdX/images with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_IMAGE

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_image("imageIdX", "catalogIdX")
  # [GET] /catalogs/catalogIdX/images/imageIdX with { headers: { "X-Access-Token": "accessTokenX" }}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX", catalog_id: "catalogIdX" }`
  ```ruby
  client.get_image("imageIdX")
  # [GET] /catalogs/catalogIdX/images/imageIdX with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_IMAGE_DATA

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_image_data("imageIdX", "catalogIdX")
  # [GET] /catalogs/catalogIdX/images/imageIdX/data with { headers: { "X-Access-Token": "accessTokenX" }}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX", catalog_id: "catalogIdX" }`
  ```ruby
  client.get_image_data("imageIdX")
  # [GET] /catalogs/catalogIdX/images/imageIdX/data with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### GET_INVENTORY

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_inventory("catalogIdX", "locationIdX")
  # [GET] /catalogs/catalogIdX/locations/locationIdX/inventory with { headers: { "X-Access-Token": "accessTokenX" }}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.get_inventory("catalogIdX")
  # [GET] /catalogs/catalogIdX/location/inventory with { headers: { "X-Access-Token": "accessTokenX" }}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX", catalog_id: "catalogIdX" }`
  ```ruby
  client.get_inventory
  # [GET] /catalogs/catalogIdX/location/inventory with { headers: { "X-Access-Token": "accessTokenX" }}
  ```

### UPDATE_INVENTORY

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.update_inventory([{sku_ref: "m9qqs"}], "catalogIdX", "locationIdX")
  # [PUT] /catalogs/catalogIdX/locations/locationIdX/inventory with { headers: { "X-Access-Token": "accessTokenX" }, body: "[{\"sku_ref\":\"m9qqs\"}]"}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.update_inventory([{sku_ref: "m9qqs"}], "catalogIdX")
  # [PUT] /catalogs/catalogIdX/location/inventory with { headers: { "X-Access-Token": "accessTokenX" }, body: "[{\"sku_ref\":\"m9qqs\"}]"}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX", catalog_id: "catalogIdX" }`
  ```ruby
  client.update_inventory([{sku_ref: "m9qqs"}])
  # [PUT] /catalogs/catalogIdX/location/inventory with { headers: { "X-Access-Token": "accessTokenX" }, body: "[{\"sku_ref\":\"m9qqs\"}]"}
  ```

### PATCH_INVENTORY

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.patch_inventory([{sku_ref: "m9qqs"}], "catalogIdX", "locationIdX")
  # [PATCH] /catalogs/catalogIdX/locations/locationIdX/inventory with { headers: { "X-Access-Token": "accessTokenX" }, body: "[{\"sku_ref\":\"m9qqs\"}]"}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.patch_inventory([{sku_ref: "m9qqs"}], "locationIdX")
  # [PATCH] /catalogs/catalogIdX/location/inventory with { headers: { "X-Access-Token": "accessTokenX" }, body: "[{\"sku_ref\":\"m9qqs\"}]"}
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX", catalog_id: "catalogIdX" }`
  ```ruby
  client.patch_inventory([{sku_ref: "m9qqs"}])
  # [PATCH] /catalogs/catalogIdX/location/inventory with { headers: { "X-Access-Token": "accessTokenX" }, body: "[{\"sku_ref\":\"m9qqs\"}]"}
  ```

### CREATE_LOYALTY_CARD

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.create_loyalty_card({ name: "bonus" }, "customerListIdX")
  # [POST] /customer_lists/customerListIdX/loyalty_cards with { headers: { "X-Access-Token": "accessTokenX" }, body: { name: "bonus" } }
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX", customer_list_id: "customerListIdX" }`
  ```ruby
  client.create_loyalty_card({ name: "bonus" })
  # [POST] /customer_lists/customerListIdX/loyalty_cards with { headers: { "X-Access-Token": "accessTokenX" }, body: { name: "bonus" } }
  ```

### CREATE_LOYALTY_OPERATION

- Initialized with `client_attrs = { access_token: "accessTokenX" }`
  ```ruby
  client.create_loyalty_operation("loyaltyCardIdX", { delta: "4.2" }, "customerListIdX")
  # [POST] /customer_lists/customerListIdX/loyalty_cards/loyaltyCardIdX/operations with { headers: { "X-Access-Token": "accessTokenX" }, body: { delta: "4.2" } }
  ```
- Initialized with `client_attrs = { access_token: "accessTokenX", customer_list_id: "q2brk" }`
  ```ruby
  client.create_loyalty_operation("loyaltyCardIdX", { delta: "4.2" })
  # [POST] /customer_lists/q2brk/loyalty_cards/loyaltyCardIdX/operations with { headers: { "X-Access-Token": "accessTokenX" }, body: { delta: "4.2" } }
  ```
