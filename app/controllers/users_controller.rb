class UsersController < ApplicationController
  def index
  end

  def show
    @client = CachingClient.new
    @user = @client.user(params[:id])
    @timeline = @client.user_timeline(params[:id])
  end
end
