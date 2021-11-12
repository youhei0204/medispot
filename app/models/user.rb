# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :image
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :likes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true, length: { maximum: 30 }
  validates :introduction, length: { maximum: 140 }

  def self.guest
    find_or_create_by!(email: 'guest@medispot.com') do |user|
      user.name = 'ゲスト'
      user.introduction = 'ゲストとしてログインしています。'
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
    end
  end
end
