# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource_or_scope)
    if current_user.admin?
      profiles_path
    else
      if current_user.profile.present? && current_user.profile.approved?
        profiles_path
      elsif current_user.profile.approved != nil || current_user.profile.approved == false 
        profile_validation_path
      elsif current_user.profile.approved.nil?
        edit_profile_path(resource)
      end
    end
    # super(resource)
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
