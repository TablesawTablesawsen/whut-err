class UsersController < ApplicationController
  def index
  end

  def show
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["YOUR_CONSUMER_KEY"]
      config.consumer_secret     = ENV["YOUR_CONSUMER_SECRET"]
    end
    @user = @client.user(params[:id])
    @timeline = @client.user_timeline(params[:id])

  end
end
