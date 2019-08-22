class CartItemsController < ApplicationController
  before_action :require_login, only:[:index , :new, :edit]

  def index
      @cart = current_user.cart
      if current_user.cart.present?
        @cart_items = current_user.cart.cart_items
      end
  end
  
  def create
    if current_user
      if current_user.cart.present?
        @product = Product.find_by_id(params[:id])
        @cart_items = current_user.cart.cart_items
        product_price = @product.price
        item = @cart_items.find_by(product_id: @product.id)
        # GST 2% on each product
        if item
          item = item.increment(:quantity, 1)
          quantity = item.quantity
          item.save
          # quantity += 1
        else
          quantity = 1
        end
        cgst = product_price * 0.02.to_d  * quantity
        sgst = product_price *0.02 * quantity
        total_tax = cgst + sgst 
        final_price = product_price * quantity + total_tax
        # Check product already present or not
        if current_user.cart.cart_items.where(product_id: @product[:id]).present?
          # update cart_items details
          @cart_item =  @product.cart_items.update(cgst: cgst, sgst: sgst, total_tax: total_tax, price: final_price)
          # find total price of cart_item
          total_price = @cart_items.sum(:price)
          cart = current_user.cart.update(total_price: total_price)
        else
          current_user.cart.update(total_price: final_price) 
          @cart_item = @product.cart_items.create(quantity: quantity, cgst: cgst, sgst: sgst, total_tax: total_tax, price: final_price, cart_id: current_user.cart.id)
        end
      else
        @cart = current_user.create_cart(total_price: product_price)
        @product = Product.find_by_id(params[:id])
        quantity = 1
        cgst = product_price * 0.02.to_d  * quantity
        sgst = product_price *0.02 * quantity
        total_tax = cgst + sgst 
        final_price = product_price * quantity + total_tax
        current_user.cart.update(total_price: final_price) 
        @cart_item = @product.cart_items.create(quantity: quantity, cgst: cgst, sgst: sgst, total_tax: total_tax, price: final_price, cart_id: current_user.cart.id)
      end 
    else
      flash[:danger] = "You must be logged in to access this section" 
      redirect_to sessions_new_path
    end
  end

  def destroy
    @cart_items = current_user.cart.cart_items
    @cart_item = @cart_items.find_by_id(params[:id])
    @cart_item.destroy
    total_price = @cart_items.sum(:price)
    cart = current_user.cart.update(total_price: total_price)

 
    redirect_to cart_items_path
  end

  def decrease_quantity
    @cart_items = current_user.cart.cart_items
    cart_item = current_user.cart.cart_items.find_by(product_id: params[:id])
    product = Product.find(params[:id])
    product_price = product.price
    cart_item.decrement(:quantity, 1)
    quantity = cart_item.quantity
    # product_price = product.price
    cgst = product_price * 0.02.to_d  * quantity
    sgst = product_price *0.02 * quantity
    total_tax = cgst + sgst 
    final_price = product_price * quantity + total_tax
    total_price = @cart_items.sum(:price)
    cart = current_user.cart.update(total_price: total_price)
    cart_item = cart_item.update(quantity: quantity, cgst: cgst, sgst: sgst, total_tax: total_tax, price: final_price)
    render :index
  end

   def increase_quantity
    @cart_items = current_user.cart.cart_items
    cart_item = current_user.cart.cart_items.find_by(product_id: params[:id])
    product = Product.find(params[:id])
    product_price = product.price
    cart_item.increment(:quantity, 1)
    quantity = cart_item.quantity
    # product_price = product.price
    cgst = product_price * 0.02.to_d  * quantity
    sgst = product_price *0.02 * quantity
    total_tax = cgst + sgst 
    final_price = product_price * quantity + total_tax
    total_price = @cart_items.sum(:price)
    cart = current_user.cart.update(total_price: total_price)
    cart_item = cart_item.update(quantity: quantity, cgst: cgst, sgst: sgst, total_tax: total_tax, price: final_price)
    render :index
  end

  private

  def require_login
    unless current_user  
      flash[:danger] = "You must be logged in to access this section"
      redirect_to sessions_new_path
    end
  end
end
