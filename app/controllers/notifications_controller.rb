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
    if notification.request_type == 1 && Review.find_by(id: notification.link_id)
      notification.update(new_flag: false)
      if current_user.notifications.where(new_flag: true).count.zero?
        current_user.update(new_notification_flag: false)
      end
      redirect_to review_path(notification.link_id)
    else
      flash[:alert] = "レビューは既に削除されています。"
      notification.destroy
      redirect_to current_user
    end
  end

  private

  def set_notifications
    if user_signed_in?
      @notifications = current_user.
        notifications.order(new_flag: :desc, created_at: :desc).limit(MAX_NOTIFICATION_NUM)
    end
    if @notifications.present? && @notifications.first.new_flag
      @new_notification_exists = true
    else
      @new_notification_exists = false
    end
  end
end
