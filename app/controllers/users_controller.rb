# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :own_user?, only: [:edit, :update]
  before_action :set_user

  def show
    @reviews = @user.reviews.order(created_at: :desc)
  end

  def edit; end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'プロフィールを更新しました'
      redirect_to @user
    else
      render 'edit'
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
