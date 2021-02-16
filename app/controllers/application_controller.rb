class ApplicationController < ActionController::Base
  helper_method :user_following?
  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :success, :info, :warning, :danger


  def user_following?(user)
    if user_signed_in? && current_user != user && current_user.following?(user)
      true
    else
      false
    end
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def authenticate_all_user!
    unless admin_signed_in? || user_signed_in?
      new_user_session_path
    end
  end
end
