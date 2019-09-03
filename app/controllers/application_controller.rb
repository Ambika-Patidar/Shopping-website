# frozen_string_literal: true

# This Class Store particular user
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_up_path_for
    redirect_to root_path
  end
end
