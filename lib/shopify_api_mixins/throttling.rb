module ApiConnection::Throttling
  extend ActiveSupport::Concern

  included do
      class_attribute :leak_rate
      self.leak_rate = 2 # 2 per second

      class_attribute :call_limit_header
      self.call_limit_header = 'X-Shopify-Shop-Api-Call-Limit'

      class_attribute :min_call_buffer
      self.min_call_buffer = 5
  end

  def handle_response(response)
    super.tap do
      if response.header[call_limit_header]
        num_calls, limit = response.header[call_limit_header].split('/').map(&:to_i)
        if limit - num_calls < min_call_buffer
          @wait_until = Time.now + ((num_calls + min_call_buffer - limit).to_f/leak_rate).seconds
        end
        logger.debug("API Calls used: #{num_calls}/#{limit}")
      end
    end
  end

  def request(*)
    if @wait_until
      sleep_time = @wait_until - Time.now
      if sleep_time > 0
        logger.info "waiting #{sleep_time} seconds to allow bucket to drain"
        sleep(sleep_time)
      end
    end

    super
  end
end
