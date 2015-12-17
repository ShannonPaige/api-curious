class TweetsController < ApplicationController

  def create
    TwitterService.new(current_user).tweet_that_shit(params[:tweet])
    redirect_to root_path
  end
end
