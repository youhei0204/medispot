class Spot < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :address, presence: true, length: { maximum: 200 }
end
