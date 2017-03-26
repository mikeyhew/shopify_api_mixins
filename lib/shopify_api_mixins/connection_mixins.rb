module ShopifyApiMixins
  module ConnectionMixins

    def retry_on_429 max_retries: 5, min_wait: 2
      require 'shopify_api_mixins/retry_on429'
      ShopifyApiMixins::RetryOn429.max_retries = max_retries
      ShopifyApiMixins::RetryOn429.min_wait = min_wait
      prepend ShopifyApiMixins::RetryOn429
    end

    def retry_on_5xx max_wait: 15.minutes, initial_wait: 0.5, backoff_multiplier: 2
      require 'shopify_api_mixins/retry_on5xx'
      ShopifyApiMixins::RetryOn5xx.max_wait = max_wait
      ShopifyApiMixins::RetryOn5xx.initial_wait = initial_wait
      ShopifyApiMixins::RetryOn5xx.backoff_multiplier = backoff_multiplier
      prepend ShopifyApiMixins::RetryOn5xx
    end

    def throttle leak_rate: 2, call_limit_header: 'X-Shopify-Shop-Api-Call-Limit', max_calls: 39
      require 'shopify_api_mixins/throttling'
      ShopifyApiMixins::Throttling.leak_rate = leak_rate
      ShopifyApiMixins::Throttling.call_limit_header = call_limit_header
      ShopifyApiMixins::Throttling.max_calls = max_calls
      prepend ShopifyApiMixins::Throttling
    end
  end
end
