require "shopify_api_mixins/version"

module ShopifyApiMixins

  class OldActiveResourceDependency < RuntimeError
  end

  unless ActiveResource::Connection.respond_to? :connection_class
    raise OldActiveResourceDependency, <<-ERROR
      Your version of activeresource is too old, and does not support the `connection_class` method. Recommend you upgrade to master. Add this to your Gemfile, replacing any existing activeresource dependency:

      gem 'activeresource', git: 'https://github.com/rails/activeresource.git'

      Then run `bundle update activeresource`.
    ERROR
  end

  require 'shopify_api_mixins/connection_mixins'
  ShopifyApi::Connection.singleton_class.prepend ConnectionMixins
end
