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
end
