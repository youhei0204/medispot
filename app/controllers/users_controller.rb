# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_user?, only: [:update]
  before_action :own_user?, only: [:edit, :update]
  before_action :set_user

  def show
    @reviews = @user.reviews.order(created_at: :desc).
      includes(:spot, images_attachments: :blob)
    @favorites = @user.favorites.order(created_at: :desc).includes(spot: :reviews)

    liked_review_ids = @user.likes.order(created_at: :desc).pluck(:review_id)
    @liked_reviews = Review.where(id: liked_review_ids).
      includes(:spot, images_attachments: :blob, user: [image_attachment: :blob]).
      sort_by { |o| liked_review_ids.index(o.id) }
    @max_review_content_length = MAX_REVIEW_CONTENT_LENGTH
  end

  def edit; end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = 'プロフィールを更新しました'
        format.html { redirect_to current_user }
      else
        format.js
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def own_user?
    redirect_to root_path unless current_user == User.find(params[:id])
  end

  def guest_user?
    guest_emails = [
      'guest_red@medispot.com',
      'guest_blue@medispot.com',
      'guest_yellow@medispot.com',
      'guest_purple@medispot.com',
      'guest_green@medispot.com',
    ]
    if guest_emails.include?(User.find_by(id: params[:id]).email)
      redirect_to root_path, alert: 'ゲストユーザーは変更・削除できません。'
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
