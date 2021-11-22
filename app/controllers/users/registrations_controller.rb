# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :guest_user?, only: [:update, :destroy]
    after_action :update_notification, only: :create
    # before_action :configure_sign_up_params, only: [:create]
    # before_action :configure_account_update_params, only: [:update]
    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    # def create
    #   super
    # end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_up_params
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    # end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    # end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
    def update_notification
      if resource.valid?
        resource.notifications.create(
          request_type: 0,
          subject: 'ようこそMediSpotへ！',
        )
        resource.update(new_notification_flag: true)
      end
    end

    def guest_user?
      if resource.email == 'guest@medispot.com'
        redirect_to root_path, alert: 'ゲストユーザーは変更・削除できません。'
      end
    end
  end
end
