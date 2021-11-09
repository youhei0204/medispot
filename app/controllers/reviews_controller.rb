class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :own_review?, only: [:edit, :update, :destroy]
  before_action :set_review, only: [:show, :edit, :update]

  def show
    @review = Review.find(params[:id])
    @other_reviews = @review.spot.reviews.where.not(id: params[:id])
  end

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    spot_info = session[:spots].find do |x|
      x["place_id"] == params[:review][:spot]
    end.deep_symbolize_keys
    spot = Spot.find_by(place_id: spot_info[:place_id])
    if spot.nil?
      spot = Spot.create!(
        name: spot_info[:name],
        address: spot_info[:formatted_address],
        lat: spot_info[:geometry][:location][:lat],
        lng: spot_info[:geometry][:location][:lng],
        place_id: spot_info[:place_id]
      )
    end

    respond_to do |format|
      @review = spot.reviews.build(review_params)
      @review.user_id = current_user.id
      if @review.save
        flash[:success] = "投稿が完了しました"
        format.html { redirect_to current_user }
      else
        format.js
      end
    end
  end

  def update
    @review = Review.find(params[:id])
    respond_to do |format|
      if @review.update(review_params)
        flash[:success] = "レビューを更新しました"
        format.html { redirect_to current_user }
      else
        format.js
      end
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = "レビューを削除しました"
    redirect_to current_user
  end
end

private

def set_review
  @review = Review.find(params[:id])
end

def own_review?
  redirect_to root_path unless current_user == Review.find(params[:id]).user
end

def review_params
  params.require(:review).permit(:review, :title, :content, :rate)
end
