module ShopifyApiMixins
  module Throttling
    class << self
      attr_accessor :leak_rate, :call_limit_header, :max_calls
    end

    def handle_response(response)
      super.tap do
        if response.header[Throttling.call_limit_header]
          num_calls, limit = response.header[Throttling.call_limit_header].split('/').map(&:to_i)
          if num_calls >= Throttling.max_calls
            @wait_until = Time.now + ((num_calls - Throttling.max_calls + 1).to_f/Throttling.leak_rate).seconds
          end
          logger&.debug("API Calls used: #{num_calls}/#{Throttling.max_calls}")
        end
      end
    end

    def request(*)
      if @wait_until
        sleep_time = @wait_until - Time.now
        if sleep_time > 0
          logger&.warn "waiting #{sleep_time} seconds to allow bucket to drain"
          sleep(sleep_time)
        end
      end

      super
    end
  end
end
