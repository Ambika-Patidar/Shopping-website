# frozen_string_literal: true

# This class uses to store products in particular user cart
class CartItemsController < ApplicationController
  before_action :require_login
  before_action :find_product, except: %i[index destroy]
  before_action :initialize_cart, only: %i[index create destroy]
  include CartItemsHelper

  def index
    @cart_items = @cart.cart_items
    if @cart_items
    else
      flash[:info] = 'Dont Have Any Items in Cart'
    end
  end

  def create
    @cart_items = @cart.cart_items
    # find_or_initialze_by
    create_and_update_cart_item(@cart_items, @products, @cart)
  end

  def destroy
    @cart_items = @cart.cart_items
    @cart_item = @cart_items.find(params[:id])
    item = @cart_item.destroy
    if item
      update_total_price_and_cart(@cart_items, @cart)
      flash[:info] = 'Successfully Remove from Cart'
      redirect_to cart_items_path
    else
      flash[:danger] = 'Item not Remove from cart'
    end
  end

  def decrease_quantity
    item, product_price = get_item_and_price
    if item.quantity > 1
      item.decrement(:quantity, 1)
      quantity_update(item, product_price)
    else
      flash[:info] = 'Minimum Quantity is 1'
    end
  end

  def increase_quantity
    item, product_price = get_item_and_price
    item.increment(:quantity, 1)
    quantity_update(item, product_price)
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def initialize_cart
    cart = current_user.cart
    @cart = cart || current_user.create_cart
  end
end
