class CartItemsController < ApplicationController
  before_action :require_login
  before_action :get_product, except:[:index, :destroy]
  include CartItemsHelper

  def index
    @cart = current_user.cart
    if @cart
      @products = current_user.cart.products
      @cart_items = @cart.cart_items
    end
  end
  
  def create
    if current_user.cart.present?
      @cart = current_user.cart
    else
      @cart = current_user.create_cart(total_price: product_price)
    end
    @cart_items = @cart.cart_items
    product_price = @product.price
    # find_or_initialze_by
    item = @cart_items.find_by(product_id: @product.id)
    # GST 2% on each product
    if item
      item = item.increment(:quantity, 1)
      quantity = item.quantity
      item.save
    else
      quantity = 1
    end
    cgst, sgst, total_tax, final_price = calculate_tax(product_price, quantity)
    # Check product already present or not
    if @cart.cart_items.where(product_id: @product[:id]).present?
      # update cart_items details
      @cart_item = @product.cart_items.update(cgst: cgst, sgst: sgst, total_tax: total_tax, price: final_price)
      # find total price of cart_item
      total_price = @cart_items.sum(:price)
      cart = @cart.update(total_price: total_price)
    else
      @cart.update(total_price: final_price) 
      @cart_item = @product.cart_items.create(quantity: quantity, cgst: cgst, sgst: sgst, total_tax: total_tax, price: final_price, cart_id: current_user.cart.id)
      flash[:info] = "Successfully Added into Cart"
    end 
  end

  def destroy
    @cart_items = current_user.cart.cart_items
    @cart_item = @cart_items.find(params[:id])
    byebug
    item = @cart_item.destroy
    if item
      total_price = @cart_items.sum(:price)
      cart = current_user.cart.update(total_price: total_price)
      flash[:info] = "Successfully Remove from Cart"
      redirect_to cart_items_path
    end
  end

  def decrease_quantity
    item, product_price = get_item_and_price
    if item.quantity > 1
      item.decrement(:quantity, 1)
      quantity = item.quantity
      cgst, sgst, total_tax, final_price = calculate_tax(product_price, quantity)
      update_cart_and_cart_item(quantity, cgst, sgst, total_tax, final_price,item)
    end
  end

   def increase_quantity
    item, product_price = get_item_and_price
    item.increment(:quantity, 1)
    quantity = item.quantity
    cgst, sgst, total_tax, final_price = calculate_tax(product_price, quantity)
    update_cart_and_cart_item(quantity, cgst, sgst, total_tax, final_price, item)
  end

  private

  def get_product
    @product = Product.find(params[:id])
  end
end
