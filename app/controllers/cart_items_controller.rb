class CartItemsController < ApplicationController
  before_action :require_login
  before_action :get_product, except:[:index, :destroy]

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
    item = @cart_items.find_by(product_id: product.id)
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
      @cart_item =  product.cart_items.update(cgst: cgst, sgst: sgst, total_tax: total_tax, price: final_price)
      # find total price of cart_item
      total_price = @cart_items.sum(:price)
      cart = @cart.update(total_price: total_price)
    else
      @cart.update(total_price: final_price) 
      @cart_item = @product.cart_items.create(quantity: quantity, cgst: cgst, sgst: sgst, total_tax: total_tax, price: final_price, cart_id: current_user.cart.id)
    end 
  end

  def destroy
    @cart_items = current_user.cart.cart_items
    @cart_item = @cart_items.find(id: params[:id])
    byebug
    @cart_item.destroy
    total_price = @cart_items.sum(:price)
    cart = current_user.cart.update(total_price: total_price)

 
    redirect_to cart_items_path
  end

  def decrease_quantity
    @cart_items = current_user.cart.cart_items
    item = @cart_items.find_by(product_id: params[:id])
    product_price = @product.price
    item.decrement(:quantity, 1)
    quantity = item.quantity
    cgst, sgst, total_tax, final_price = calculate_tax(product_price, quantity)
    update_cart_and_cart_item(quantity, cgst, sgst, total_tax, final_price,item)
  end

   def increase_quantity
    @cart_items = current_user.cart.cart_items
    item = @cart_items.find_by(product_id: params[:id])
    # product = get_product
    product_price = @product.price
    item.increment(:quantity, 1)
    quantity = item.quantity
    # product_price = product.price
    cgst, sgst, total_tax, final_price = calculate_tax(product_price, quantity)
    update_cart_and_cart_item(quantity, cgst, sgst, total_tax, final_price, item)
  end

  private

  def get_product
    @product = Product.find(params[:id])
  end

  def  calculate_tax(product_price, quantity)
    cgst = product_price * 0.02.to_d  * quantity
    sgst = product_price *0.02 * quantity
    total_tax = cgst + sgst 
    final_price = product_price * quantity + total_tax
    return cgst, sgst, total_tax, final_price
  end

  def update_cart_and_cart_item(quantity, cgst, sgst, total_tax, final_price, item)
    total_price = @cart_items.sum(:price)
    cart = current_user.cart.update(total_price: total_price)
    item = item.update(quantity: quantity, cgst: cgst, sgst: sgst, total_tax: total_tax, price: final_price)
    redirect_to cart_items_path
  end

end
