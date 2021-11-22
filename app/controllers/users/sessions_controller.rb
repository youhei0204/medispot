# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def guest_sign_in
      user = User.guest
      sign_in user
      update_notification
      redirect_to after_sign_in_path_for(user), notice: 'ゲストとしてログインしました。'
    end

    # before_action :configure_sign_in_params, only: [:create]
    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    def create
      super
      about_notification = current_user.notifications.find_by(request_type: 0)
      if about_notification.present? && about_notification.new_flag
        about_notification.update(created_at: Time.now)
      end
    end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end

    private

    def update_notification
      current_user.notifications.find_by(request_type: 0)&.destroy
      current_user.notifications.create(
        request_type: 0,
        subject: 'ようこそMediSpotへ！',
      )
      current_user.update(new_notification_flag: true)
    end
  end
end
