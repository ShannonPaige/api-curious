class FavoritesController < ApplicationController
  def update
    
    current_user.make_favorite(params[:tweet])
    redirect_to root_path
  end
end
