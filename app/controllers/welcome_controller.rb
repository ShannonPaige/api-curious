class WelcomeController < ApplicationController
  def index
    @twitter_service = TwitterService.new(current_user)
  end

end
