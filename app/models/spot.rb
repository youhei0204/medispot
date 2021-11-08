class Spot < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, presence: true, length: { maximum: 100 }
  validates :address, presence: true, length: { maximum: 200 }
  validates :lat, presence: true
  validates :lng, presence: true
  validates :place_id, presence: true, uniqueness: true
end
