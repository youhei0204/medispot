# frozen_string_literal: true

class ApplicationController < ActionController::Base
  MAX_REVIEW_CONTENT_LENGTH = 70
  MAX_RECENT_REVIEW_CONTENT_LENGTH = 30
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :html, :json

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def update_new_notification_flag(user)
    if user.notifications.where(new_flag: true).count.zero?
      user.update(new_notification_flag: false)
    else
      user.update(new_notification_flag: true)
    end
  end
end
