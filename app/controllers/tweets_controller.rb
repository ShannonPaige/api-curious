class TweetsController < ApplicationController

  def create
    TwitterService.new(current_user).tweet_it(params[:tweet])
    redirect_to root_path
  end
end
