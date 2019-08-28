# frozen_string_literal: true

# This class used to store Order Items of Paticular user.
class OrderItemsController < ApplicationController
  before_action :require_login, only: %i[index show order_display create]
  before_action :find_address, only: %i[create]
  before_action :find_user_address, only: %i[create order_display]
  before_action :user_cart_and_cartitems, only: %i[create order_display]
  before_action :find_orders, except: %i[order_display]
  include OrderItemsHelper

  def index; end

  def show
    @order = @orders.find(params[:id])
    @order_items = @order.order_items
  end

  def create
    total_price = @cart_items.sum(:price)
    if @cart_items.present?
      @order = @orders.create(total_price: total_price, address_id: @address.id)
      create_cart_item(@order)
      flash[:info] = 'Thank You for Shopping'
      redirect_to order_item_path(id: @order)
    else
      flash[:danger] = 'Cart is Empty'
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

  def find_orders
    @orders = current_user.orders
  end

  def find_address
    @address = current_user.addresses.find(params[:id]).id
  end

  def find_user_address
    @addresses = current_user.addresses
    @address = @addresses.find_by(default: true)
  end

  def user_cart_and_cartitems
    @cart = current_user.cart
    @cart_items = @cart.cart_items
  end
end
