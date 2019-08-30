# frozen_string_literal: true

# This Class Store particular user
class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user = User.find_by_id(session[:user_id])
  end

  def require_login
    if current_user
    else
      flash[:danger] = 'You must be logged in to access this section'
      redirect_to sessions_new_path
    end
  end
end
