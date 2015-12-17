class RetweetsController < ApplicationController
  def create
    TwitterService.new(current_user).retweet_it(params[:id])
    redirect_to root_path
  end
end
