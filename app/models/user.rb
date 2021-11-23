# frozen_string_literal: true

class User < ApplicationRecord
  GUEST_USER_NUM = 5
  has_one_attached :image
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true, length: { maximum: 30 }
  validates :introduction, length: { maximum: 140 }
  validates :new_notification_flag, inclusion: { in: [true, false] }

  def self.guest
    colors = ['red', 'blue', 'yellow', 'purple', 'green']
    colors_to_jp = { 'red' => '赤', 'blue' => '青', 'yellow' => '黄', 'purple' => '紫', 'green' => '緑' }

    guest_users = User.where("email like 'guest_%@medispot.com'").where.not(confirmed_at: nil)
    if guest_users.count == GUEST_USER_NUM
      guest_users.joins(:notifications).order('notifications.created_at').first
    else
      colors.each do |color|
        if !User.find_by(email: "guest_#{color}@medispot.com")
          user = User.create(
            name: "ゲスト(#{colors_to_jp[color]})",
            email: "guest_#{color}@medispot.com",
            introduction: "ゲスト(#{colors_to_jp[color]})としてログインしています。",
            password: SecureRandom.urlsafe_base64,
            confirmed_at: Time.now
          )
          return user
        end
      end
    end
  end
end
