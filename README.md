# Shopify Api Mixins

Useful mixins for working with the `shopify_api` gem.

## Dependencies

You need to have a recent-enough version of `activeresource`, with support for the `ActiveResource::Base.connection_class` class_variable. At the time of writing, there are no releases on rubygems that support it yet, and you need to use the master branch on GitHub (rails/activeresource). If you have an old version of activeresource that doesn't have `connection_class`, then this gem will raise a runtime error when it is `required`.

For the `shopify_api` gem, you'll want as new of a version as possible; or at least version 4.3.1.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shopify_api_mixins'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shopify_api_mixins

## Usage

This gem adds a few class methods to `ShopifyAPI::Connection`. Use them like so:

```ruby
ShopifyAPI::Connection.retry_on_429 max_retries: 5, min_wait: 2.seconds
ShopifyAPI::Connection.retry_on_5xx max_wait: 15.minutes
```

If you are outside of the rails environment and get ``NoMethodError: undefined method `retry_on_429' for ShopifyAPI::Connection:Class``, you need to `require 'shopify_api_mixins'`.

## Testing

After checking out the repo, run `bundle install` to install dependencies.

There are some basic tests you can run with

```bash
bundle exec rake test
```

There is also a script that tests out the retry-on-429 functionality that you can run like this:

```txt
TEST_SHOP_URL=api_key:password@shop-subdomain.myshopify.com/admin bin/test_429
```

where `api_key` and `password` are your private app's credentials, and `shop-domain` is, well, your shop's subdomain. You may also create a `.env` file and put TEST_SHOP_URL in there (it will be loaded automatically).

The script just sends a bunch of requests to your shop in an infinite loop. After a while, you should notice the script hanging for a couple of seconds as it gets HTTP 429 status codes from Shopify. If it does, then everything works and you can stop the script with ctrl-C. You can speed up the process by running the script in multiple terminals at the same time.

## Releasing (if I ever do a release on rubygems)

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mikeyhew/shopify_api_mixins. Make sure to run tests first, because there's no CI set up right now.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
