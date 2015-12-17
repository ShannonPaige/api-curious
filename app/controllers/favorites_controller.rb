class FavoritesController < ApplicationController
  def create
    TwitterService.new(current_user).favorite_it(params[:id])
    redirect_to root_path
  end
end
