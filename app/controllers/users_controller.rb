class UsersController < ApplicationController
  def show
    @user = current_user
    raise :test
    redirect_to root_path
  end
end
