class OrderItemsController < ApplicationController
  before_action :require_login, only:[:index]
  
  def index 
    @order = OrderItem.new
    @address = current_user.addresses
  end
  
end
