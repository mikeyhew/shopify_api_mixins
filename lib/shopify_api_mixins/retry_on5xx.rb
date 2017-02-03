class ApiConnection < ShopifyAPI::Connection
  module RetryOn5xx
    extend ActiveSupport::Concern

    def request(*)
      with_retrial_on_5xx do
        super
      end
    end

    private

    def with_retrial_on_5xx
      retries = 0
      time_of_first_try = Time.now
      max_wait = 15.minutes

      loop do
        begin
          return yield
        rescue ActiveResource::ServerError => e
          if time_of_first_try < max_wait.ago
            actual_wait_time = Time.now - time_of_first_try
            logger.error "Recieved too many server errors. Retried #{retries} times over the course of #{actual_wait_time} seconds. Last error was #{e.response.code}: #{e.response.message}:\n#{e.response.body}"
            raise
          end
          code = e.response.code.to_i
          delay = 2**retries
          logger.info "Got a #{code}, will sleep for #{delay} seconds and retry"
          sleep(delay)
          retries += 1
          next
        end
      end
    end
  end
end
