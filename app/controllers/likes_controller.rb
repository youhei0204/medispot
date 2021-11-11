class LikesController < ApplicationController
  def create
    current_user.likes.create(review_id: params[:review_id])
  end

  def destroy
    like = current_user.likes.find_by(review_id: params[:review_id])
    like.destroy if like.present?
  end
end
