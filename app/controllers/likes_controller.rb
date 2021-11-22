class LikesController < ApplicationController
  def create
    if current_user.likes.create(review_id: params[:review_id])
      update_notification
    end
  end

  def destroy
    like = current_user.likes.find_by(review_id: params[:review_id])
    like.destroy if like.present?
  end

  private

  def update_notification
    reviewer = Review.find_by(id: params[:review_id]).user
    if current_user != reviewer
      reviewer.notifications.
        find_by(
          sender_id: current_user.id,
          request_type: 1,
          link_id: params[:review_id]
        )&.destroy

      reviewer.notifications.create(
        sender_id: current_user.id,
        sender_name: current_user.name,
        request_type: 1,
        subject: Review.find_by(id: params[:review_id]).title,
        link_id: params[:review_id],
      )
      update_new_notification_flag reviewer
    end
  end
end
