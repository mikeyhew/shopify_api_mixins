require 'test_helper'

class BasicTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ShopifyApiMixins::VERSION
  end

  def test_theres_no_errors
    ::ShopifyAPI::Connection.retry_on_429
    ::ShopifyAPI::Connection.retry_on_5xx
    ::ShopifyAPI::Connection.throttle
  end
end
