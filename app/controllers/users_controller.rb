# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :own_user?, only: [:edit, :update]
  before_action :set_user

  def show
    @reviews = @user.reviews.order(created_at: :desc).
      includes(:spot, images_attachments: :blob)
    @favorites = @user.favorites.order(created_at: :desc).includes(spot: :reviews)
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

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
