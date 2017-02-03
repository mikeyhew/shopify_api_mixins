# Shopify Api Mixins

Useful mixins for working with the shopify_api gem.

## Dependencies

You need to have a recent-enough version of ActiveResource, with support for the `ActiveResource::Base.connection_class` class_variable. At the time of writing, there are no releases on rubygems that support it yet, and you need to use the master branch on GitHub (rails/activeresource).

For the `shopify_api` gem, you'll want as new of a version as possible; or at least version 4.1.

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

You can just prepend the mixins to `ShopifyAPI::Connection`:

```ruby
    ShopifyAPI::Connection.prepend ShopifyApiMixins::RetryOn429
    ShopifyAPI::Connection.prepend ShopifyApiMixins::RetryOn5xx
    ShopifyAPI::Connection.prepend ShopifyApiMixins::Throttling
```

Or, create and use your own Connection class

```ruby
    class ApiConnection < ShopifyAPI::Connection
        include ShopifyApiMixins::RetryOn429
        include ShopifyApiMixins::RetryOn5xx
        include ShopifyApiMixins::Throttling
    end

    ShopifyAPI::Base.connection_class = ApiConnection
```

If you're outside of rails' auto-loading environment, you may also need to throw in a few `require` statements.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mikeyhew/shopify_api_mixins.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

