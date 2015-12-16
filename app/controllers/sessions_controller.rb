class SessionsController < ApplicationController
  def create
    # raise :test
    if user = User.find_or_create_from_omniauth(auth_info)
      session[:user_id] = user.id
    end
    redirect_to root_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

    def auth_info
      request.env["omniauth.auth"]
    end
end
