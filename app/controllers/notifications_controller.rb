class NotificationsController < ApplicationController
  MAX_NOTIFICATION_NUM = 10
  before_action :set_notifications, only: :index
  def index
    respond_to do |format|
      format.js
    end
  end

  def show
    notification = Notification.find(params[:id])
    notification.update(new_flag: false)
    update_new_notification_flag current_user
    if notification.request_type == 0
      respond_to do |format|
        format.js
      end
    end
    if notification.request_type == 1
      if Review.find_by(id: notification.link_id)
        redirect_to review_path(notification.link_id)
      else
        flash[:alert] = "レビューは既に削除されています。"
        notification.destroy
        redirect_to current_user
      end
    end
  end

  private

  def set_notifications
    if user_signed_in?
      @notifications = current_user.
        notifications.order(new_flag: :desc, created_at: :desc).limit(MAX_NOTIFICATION_NUM)
    end
  end
end
