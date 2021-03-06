# frozen_string_literal: true

# This class Manage particular User through Session
class SessionsController < ApplicationController
  layout 'login'
  def new; end

  def create
    user = User.find_by(email: user_params[:email])
    if user&.authenticate(user_params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Successfully Login'
      redirect_to dashboard_index_path
    else
      flash[:danger] = 'Invalid email and password'
      redirect_to sessions_new_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:secondary] = 'Successfully logout'
    redirect_to home_index_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
