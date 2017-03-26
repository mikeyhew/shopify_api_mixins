require "shopify_api_mixins/version"

module ShopifyApiMixins
  require 'shopify_api_mixins/connection_mixins'
  ShopifyApi::Connection.singleton_class.prepend ConnectionMixins
end
