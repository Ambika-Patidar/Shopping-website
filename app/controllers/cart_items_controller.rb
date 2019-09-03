# frozen_string_literal: true

# This class uses to store products in particular user cart
class CartItemsController < ApplicationController
  before_action :find_product, except: %i[index destroy]
  before_action :find_cart_and_items, onlt: %i[index destroy create]
  include CartItemsHelper

  def index
    flash[:info] = if @cart_items
                     'Your Cart Items'
                   else
                     'Dont Have Any Items in Cart'
                   end
  end

  def create
    item = @cart_items.find_or_initialize_by(product_id: @product.id)
    quantity = item.new_record? ? 1 : item.quantity + 1

    cgst, sgst, price = calculate_tax(@product.price, quantity)

    create_item_in_cart_items(item, cgst, sgst, price, quantity)
    update_total_price_and_cart(@cart_items, @cart)
    flash[:info] = 'Successfully Added into Cart'
    redirect_to dashboard_index_path
  end

  def destroy
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
    item, product_price = find_item_and_price
    if item.quantity > 1
      item.decrement(:quantity, 1)
      quantity_update(item, product_price)
      flash[:info] = 'Your Item Quantity has update'
    else
      flash[:info] = 'Minimum Quantity is 1'
    end
  end

  def increase_quantity
    item, product_price = find_item_and_price
    item.increment(:quantity, 1)
    quantity_update(item, product_price)
    flash[:info] = ' Your Item Quantity has update'
  end

  private

  def find_product
    @product = Product.find_by_id(params[:id])
  end

  def find_cart_and_items
    @cart = current_user.cart
    @cart_items = @cart.cart_items
  end
end
