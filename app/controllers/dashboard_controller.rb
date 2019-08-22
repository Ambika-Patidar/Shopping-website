class DashboardController < ApplicationController
  before_action :require_login, only:[ :index]
  # before_action :require_sign_up, only:[ :index]
  def index
    @products = Product.all
    # Welcome to current_user.first_name
  end

  def show
    @product = Product.find_by_id(params[:id])
  end

  private

  def require_login
    unless current_user  
     flash[:danger] = "You must be logged in to access this section"
     redirect_to sessions_new_path
    end
  end

end
