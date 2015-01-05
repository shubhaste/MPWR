class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_current_user
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def after_sign_in_path_for(user)
        companies_path
    end
 def set_current_user
      User.current = current_user
 end
protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username,:email, :password, :password_confirmation, roles: [])}
  end
end
