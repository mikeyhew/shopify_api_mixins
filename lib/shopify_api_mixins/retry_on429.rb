module ApiConnection::RetryOn429
  extend ActiveSupport::Concern

  def request(*)
    with_retrial_on_429 do
      super
    end
  end

  private

  def with_retrial_on_429
    max_retries = 5

    min_wait = 2

    max_retries.times do
      begin
        return yield
      rescue ActiveResource::ClientError => e
        case code = e.response.code.to_i
        when 429
          wait_time = e.response['Retry-After'.freeze].to_i
          wait_time = min_wait if wait_time < min_wait
          logger.info "Got a 429, will retry in #{wait_time} seconds"
          sleep(wait_time)
          next
        else
          raise
        end
      end
    end
    yield
  end
end
