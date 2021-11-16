class Review < ApplicationRecord
  has_many_attached :images
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :spot
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 2000 }
  validates :rate, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5.0,
    message: 'を選択してください'
  }
end
