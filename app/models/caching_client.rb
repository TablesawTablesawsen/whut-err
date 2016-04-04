class CachingClient
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["YOUR_CONSUMER_KEY"]
      config.consumer_secret     = ENV["YOUR_CONSUMER_SECRET"]
    end
  end

  def method_missing(m, *args, &block)
    Rails.cache.fetch(m.to_s + args.to_s, expires_in: 5.minutes) do
      @client.send(m, *args, &block)
    end
  end
end
