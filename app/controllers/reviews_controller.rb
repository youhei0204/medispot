class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :own_review?, only: [:edit, :update, :destroy]
  before_action :set_review, only: [:show, :edit, :update]

  def show
  end

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "レビューを投稿しました"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def update
    if @review.update(review_params)
      flash[:success] = "レビューを更新しました"
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = "レビューを削除しました"
    redirect_to current_user
  end
end

private

def set_review
  @review = Review.find(params[:id])
end

def own_review?
  redirect_to root_path unless current_user == Review.find(params[:id]).user
end

def review_params
  params.require(:review).permit(:review, :title, :content, :rate)
end
