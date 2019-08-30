# frozen_string_literal: true

# This Class Used to Store Particular User Data.
class RegistrationsController < ApplicationController
  layout 'login', except: %i[index]
  layout 'application', only: %i[index]

  def index
    flash[:info] = 'Your Profile'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:info] = 'You Sign Up Successfully'
      redirect_to  dashboard_index_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
