class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied, with: :access_denied

  private

  def access_denied
    flash[:alert] = 'You are not authorized to access this page.'
    redirect_back(fallback_location: root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[role name])
  end

end
