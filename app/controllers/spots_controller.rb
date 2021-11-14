class SpotsController < ApplicationController
  before_action :authenticate_user!
  MAX_SLIDER_IMAGE_NUM_FOR_SHOW = 7
  MAX_SLIDER_IMAGE_NUM_FOR_INDEX = 3
  MAX_SEARCH_SPOT_NUM = 100

  def show
    @spot = Spot.find(params[:id])
    @reviews = @spot.reviews.includes(user: [image_attachment: :blob])
    @images = @spot.images(MAX_SLIDER_IMAGE_NUM_FOR_SHOW)
    @max_review_content_length = MAX_REVIEW_CONTENT_LENGTH
  end

  def index
    @area = params[:area]
    @keyword = params[:keyword]
    if params[:area].empty? && params[:keyword].empty?
      redirect_to request.referer
    else
      @max_slider_image_num = MAX_SLIDER_IMAGE_NUM_FOR_INDEX
      @spots = searched_spot
    end
  end

  private

  def searched_spot
    area_matched_spot_ids = Spot.where('address LIKE ?', "%#{@area}%").pluck(:id)

    name_matched_spot_ids    = Spot.where('name LIKE ?', "%#{@keyword}%").pluck(:id)
    title_matched_spot_ids   = Review.where('title LIKE ?', "%#{@keyword}%").pluck(:spot_id)
    content_matched_spot_ids = Review.where('content LIKE ?', "%#{@keyword}%").pluck(:spot_id)
    keyword_matched_spot_ids =
      name_matched_spot_ids | title_matched_spot_ids | content_matched_spot_ids
    result_ids = (area_matched_spot_ids & keyword_matched_spot_ids).first(MAX_SEARCH_SPOT_NUM)
    Spot.where(id: result_ids)
  end
end
