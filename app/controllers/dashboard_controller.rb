class DashboardController < ApplicationController
  before_action :require_login, only:[:index]
  
  def index
    @products = Product.where.not(user_id: current_user.id)
  end

  def show
    @user = current_user
    byebug
  end
end
