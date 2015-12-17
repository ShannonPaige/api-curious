class FriendsController < ApplicationController
  def destroy
    TwitterService.new(current_user).unfollow_this_guy(params[:id])
    redirect_to root_path
  end
end
