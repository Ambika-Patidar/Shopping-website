class HomeController < ApplicationController
  layout "login"
  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by_id(params[:id])
  end

end
