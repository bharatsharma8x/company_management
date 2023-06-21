class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied, with: :access_denied

  private

  def access_denied
    flash[:alert] = "You are not authorized to access this page."
    redirect_back(fallback_location: root_path)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name])
  end

end
# before_action :remove_whitespace

# def sanitize_data(hash)
#   result_hash = {}
#   return hash unless hash.respond_to?(:keys)

#   hash.keys.each do |key|
#     result_hash[key] = hash[key].squish if hash[key].is_a?(String)
#   end

#   result_hash
# end

# def remove_whitespace
#   params.keys.each do |key|
#     if params[key].respond_to?(:each)
#       params[key] = sanitize_data(params[key])
#      elsif params[key].is_a?(String)
#       params[key] = params[key].squish
#      else
#       params[key] = params[key]
#      end
#   end
# end
