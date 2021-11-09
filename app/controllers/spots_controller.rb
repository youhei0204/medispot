class SpotsController < ApplicationController
  MAX_SLIDER_IMAGE_NUM = 7
  @max_slider_image_num = MAX_SLIDER_IMAGE_NUM
  def show
    @max_slider_image_num = MAX_SLIDER_IMAGE_NUM
    @spot = Spot.find(params[:id])
  end
end
