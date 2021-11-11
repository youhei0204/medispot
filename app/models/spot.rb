class Spot < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :name, presence: true, length: { maximum: 100 }
  validates :address, presence: true, length: { maximum: 200 }
  validates :lat, presence: true
  validates :lng, presence: true
  validates :place_id, presence: true, uniqueness: true

  def average_rate
    reviews.average(:rate)
  end

  def images(num)
    images = []
    is_break = false
    reviews.includes(images_attachments: :blob).each do |review|
      review.images.each do |image|
        images << image
        if images.length >= num
          is_break = true
          break
        end
      end
      break if is_break
    end
    images
  end
end
