class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def after_sign_in_path_for(resource)
    conditions_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :date_of_birth, :gender])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :date_of_birth, :gender])
  end
end
