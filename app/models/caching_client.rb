class CachingClient
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["YOUR_CONSUMER_KEY"]
      config.consumer_secret     = ENV["YOUR_CONSUMER_SECRET"]
    end
  end

  def user(id)
    Rails.cache.fetch("user/" + id, expires_in: 5.minutes) do
      @client.user(id)
    end
  end

  def user_timeline(id)
    Rails.cache.fetch("user_timeline/" + id, expires_in: 5.minutes) do
      @client.user_timeline(id)
    end
  end
end
