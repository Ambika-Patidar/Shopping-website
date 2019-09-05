# frozen_string_literal: true

# This Class Store particular user
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  def after_sign_up_path_for
    redirect_to dashboard_index_path
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_index_path
  end
end
