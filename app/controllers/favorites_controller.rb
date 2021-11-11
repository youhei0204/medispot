class FavoritesController < ApplicationController
  def create
    current_user.favorites.create(spot_id: params[:spot_id])
  end

  def destroy
    favorite = current_user.favorites.find_by(spot_id: params[:spot_id])
    favorite.destroy if favorite.present?
  end
end
