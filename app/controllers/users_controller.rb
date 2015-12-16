class UsersController < ApplicationController

  def show
    @user = current_user.twitter.user
  end
end
