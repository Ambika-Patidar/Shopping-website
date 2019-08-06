class SessionsController < ApplicationController

  def new
    user = User.new
  end

  def create
    
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
       session[:user_id] = user.id 
       redirect_to dashboard_index_path
    else
      flash[:warning] = "Invalid email and password" 
      redirect_to root_path 
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password )
    end

end
