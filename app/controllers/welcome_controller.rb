class WelcomeController < ApplicationController
  def index
    @twitter_service = TwitterService.new(current_user) if current_user
  end

end
