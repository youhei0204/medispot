# frozen_string_literal: true

class HomePagesController < ApplicationController
  MAX_RECENT_REVIEW_NUM = 5
  MAX_POPULAR_SPOT_NUM = 8
  MAX_SPOT_IMAGE_NUM = 1

  def home
    @recent_reviews = Review.order(created_at: :desc).
      includes(:spot,
        images_attachments: :blob,
        user: [image_attachment: :blob]).first(MAX_RECENT_REVIEW_NUM)
    @popular_spots = popular_spots(MAX_POPULAR_SPOT_NUM)
    @max_spot_image_num = MAX_SPOT_IMAGE_NUM
  end

  private

  def popular_spots(num)
    recent_reviews = Review.where(created_at: Time.now.prev_month.beginning_of_month..Time.now)
    spot_recent_average_rate_ids = recent_reviews.group(:spot_id).average(:rate)
    spot_recent_rate_count_ids = recent_reviews.group(:spot_id).count

    spot_score_ids = spot_recent_rate_count_ids.map do |k, v|
      [k, (1 + v * 0.1) * spot_recent_average_rate_ids[k]]
    end.to_h.sort_by { |k, v| -v }.map(&:first)

    spot_score_ids.map { |i| Spot.find_by(id: i) }.first(num)
  end
end
