class ReviewsController < ApplicationController
  MAX_IMAGE_UPLOAD_NUM = 4
  before_action :authenticate_user!
  before_action :own_review?, only: [:edit, :update, :destroy]
  before_action :set_review, only: [:show, :edit, :update]

  def show
    @other_reviews = @review.spot.reviews.where.not(id: params[:id])
  end

  def new
    @review = Review.new
  end

  def edit
    @images = @review.images.includes(:blob)
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
    if params[:initial_image_keys].nil?
      delete_images = @review.images.attached? ? @review.images : []
    else
      delete_images = @review.images.select do |image|
        !params[:initial_image_keys].include?(image.key)
      end
    end
    respond_to do |format|
      if params[:initial_image_keys]&.length.to_i +
          params[:review][:images]&.length.to_i > MAX_IMAGE_UPLOAD_NUM
        format.html { redirect_to current_user }
      else
        if @review.update(review_params)
          delete_images.map(&:purge)
          flash[:success] = "レビューを更新しました"
          format.html { redirect_to current_user }
        else
          format.js
        end
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
  params.require(:review).permit(:review, :title, :content, :rate, images: [])
end
