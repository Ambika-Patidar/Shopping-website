class HomeController < ApplicationController
  layout "login"
  
  def index
    @products = Product.all
  end

end
