class OrderItemsController < ApplicationController
  before_action :require_login, only:[:index, :show, :order_display, :create]
  before_action :get_address, except:[:show, :index]
  before_action :get_user_addresses, only:[:create, :order_display]

  def index
    @orders = current_user.orders

  end
  
  def show
    @order = current_user.orders.find(params[:id])
    @order_items = @order.order_items
  end

  def create
    @cart_items = current_user.cart.cart_items
    total_price = @cart_items.sum(:price)
    if @cart_items.present?
      @order = current_user.orders.create(total_price: total_price, address_id: address.id)
      @cart_items.each do |cart_item|
        order_item = @order.order_items.create(quantity: cart_item.quantity, cgst: cart_item.cgst, sgst: cart_item.sgst, total_tax: cart_item.total_tax, price: cart_item.price, product_id: cart_item.product_id)
        cart_item.destroy
      end  
      flash[:info] = "Thank You for Shopping"
      redirect_to order_item_path(id: @order)
    else
      flash[:danger] = "Cart is Empty" 
      redirect_to cart_items_path
    end
  end

  def order_display 
    @order = OrderItem.new
    @cart = current_user.cart
    @cart_items = @cart.cart_items
    @products = current_user.cart.products
  end
  
  private
  
  def get_address
    @address = current_user.addresses.find(params[:id]).id
  end

  def get_user_address
    @addresses = current_user.addresses
    @address = @addresses.find_by(default: tru
  end

end
