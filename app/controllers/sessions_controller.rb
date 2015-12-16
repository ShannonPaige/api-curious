class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(auth_info)
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
