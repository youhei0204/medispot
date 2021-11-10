class SpotsController < ApplicationController
  MAX_SLIDER_IMAGE_NUM_FOR_SHOW = 7
  MAX_SLIDER_IMAGE_NUM_FOR_INDEX = 3

  def show
    @max_slider_image_num = MAX_SLIDER_IMAGE_NUM_FOR_SHOW
    @spot = Spot.find(params[:id])
  end

  def index
    @area = params[:area]
    @keyword = params[:keyword]
    if params[:area].empty? && params[:keyword].empty?
      redirect_to request.referer
    else
      @max_slider_image_num = MAX_SLIDER_IMAGE_NUM_FOR_INDEX
      @spots = searched_spot.first(100)
    end
  end

  private

  def searched_spot
    area_matched_spots = Spot.where('address LIKE ?', "%#{@area}%")

    name_matched_spots    = Spot.where('name LIKE ?', "%#{@keyword}%")
    title_matched_spots   = Review.where('title LIKE ?', "%#{@keyword}%").map(&:spot)
    content_matched_spots = Review.where('content LIKE ?', "%#{@keyword}%").map(&:spot)
    keyword_matched_spots = name_matched_spots | title_matched_spots | content_matched_spots

    area_matched_spots & keyword_matched_spots
  end
end
