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

## Development

After checking out the repo, run `bundle install` to install dependencies.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mikeyhew/shopify_api_mixins.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
