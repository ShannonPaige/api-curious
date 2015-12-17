class SessionsController < ApplicationController
  def create
    if user = User.find_or_create_from_omniauth(auth_info)
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to root_path
    end
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
