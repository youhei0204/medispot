# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :own_page?, only: %i[edit update]
  before_action :set_user

  def show; end

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

  def own_page?
    redirect_to root_path unless current_user == User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end
