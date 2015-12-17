class FavoritesController < ApplicationController
  def update
    TwitterService.new(current_user).favorite_it(params[:id])
    redirect_to root_path
  end
end
