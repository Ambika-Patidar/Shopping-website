class RegistrationsController < ApplicationController
  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
       flash[:success] = "You Sign Up Successfully "
       redirect_to  root_path
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:registration).permit(:first_name, :last_name, :email, :password)
    end
end
