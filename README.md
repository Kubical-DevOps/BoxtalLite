# BoxtalLite

Boxtal.com API client
Boxtal has got two coexisting APIs: v3 and v1. 
This gem makes use of both these APIs, as follows:
- Authentication via API v3 and v1
- Service via API v1
- Order via API v3
- Subscribe via API v3

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'boxtal_lite'
```

## Configuration

```ruby
#API v3
BoxtalLite.configure do |config| 
  config.api_key = ENV['BOXTAL_API_KEY']
  config.testing = true
end
#API v1
BoxtalLite.configure do |config| 
  config.v1_api_key = ENV['BOXTAL_V1_API_KEY']
  config.v1_creds = ENV['BOXTAL_V1_CREDS']
  config.testing = true
end
```

API key can be passed via options too:

```ruby
BoxtalLite::Service.all(query, api_key: 'mykey')
```

Boxtal's V1 API (only V1) uses HTTP Basic authentication. User's credentials (base64) can be passed via options too: 

```ruby
BoxtalLite::Service.all(query, creds: 'mycreds')
```


## Usage

### Fetch services list

```ruby
  services = BoxtalLite::Service.all(
    { 'shipper.country': 'FR', 'shipper.zipcode': '75009', 'shipper.type': 'company', #from
      'recipient.country': 'FR', 'recipient.zipcode': '69100', 'recipient.type': 'individual', #to
      'colis_0.largeur': 10 ,'colis_0.hauteur': 10, 'colis_0.longueur': 10, 'colis_0.poids': 0.5, 'colis.valeur': 15, #dimensions
      'collection_date': '2021-10-18', 'content_code': '40120' 
    })
```
To understand the params, please refer to : https://www.boxtal.com/fr/fr/api

### Create order

```ruby
  order = BoxtalLite::Order.create(order_hash)
```

### Subscribe to webhooks and set callback urls

Subcribe to Boxtal's webhooks for Label/Document creation or for shipment tracking information
  ```ruby
  BoxtalLite::Subscription.create(
    {
    'eventType': 'DOCUMENT_CREATED', #Or TRACKING_CHANGED
    'callbackUrl': '<your-callback-url>'
    }
  )
  ```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Kubical-DevOps/BoxtalLite


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

