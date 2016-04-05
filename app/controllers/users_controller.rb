class UsersController < ApplicationController
  def show
    if params[:screenname]
      return redirect_to user_path(params[:screenname])
    end

    @client = CachingClient.new
    @user = @client.user(params[:id])
    @timeline = @client.user_timeline(params[:id])
  end
end
