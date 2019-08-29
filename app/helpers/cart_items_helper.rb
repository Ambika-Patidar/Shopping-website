module CartItemsHelper
  def calculate_tax(product_price, quantity)
    cgst = product_price * 0.02.to_d  * quantity
    sgst = product_price *0.02 * quantity
    price = product_price * quantity + cgst +sgst
    return cgst, sgst, price
  end

  def update_cart_and_cart_item(quantity, cgst, sgst, final_price, item)
    total_price = @cart_items.sum(:price)
    cart = current_user.cart.update(total_price: total_price)
    item = item.update(quantity: quantity, cgst: cgst, sgst: sgst, price: final_price)
    redirect_to cart_items_path
  end

  def get_item_and_price
    @cart_items = current_user.cart.cart_items
    item = @cart_items.find_by(product_id: params[:id])
    product_price = @product.price
    return item, product_price
  end

  def quantity_update(item, product_price)
    quantity = item.quantity
    cgst, sgst, final_price = calculate_tax(product_price, quantity)
    update_cart_and_cart_item(quantity, cgst, sgst, final_price, item)
  end

  def update_total_price_and_cart(cart_items, cart)
    total_price = cart_items.sum(:price)
    cart.update(total_price: total_price)
  end

  def create_item_in_cart_items(item, cgst, sgst , price)
    if item.new_record?
      # update cart_items details
      item.update(
        cgst: cgst,
        sgst: sgst,
        price: price
      )
    end
  end
end
