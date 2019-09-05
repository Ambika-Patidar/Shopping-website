# frozen_string_literal: true

# This module user for cart items controller
module CartItems
  GST_PER = 0.02
  def calculate_tax(product_price, quantity)
    cgst = product_price * GST_PER * quantity
    sgst = product_price * GST_PER * quantity
    price = product_price * quantity + cgst + sgst
    [cgst, sgst, price]
  end

  def update_cart_and_cart_item(quantity, cgst, sgst, final_price, item)
    total_price = @cart_items.sum(:price)
    current_user.cart.update(total_price: total_price)
    item.update(quantity: quantity, cgst: cgst, sgst: sgst, price: final_price)
  end

  def find_item_and_price
    @cart_items = current_user.cart.cart_items
    item = @cart_items.find_by(product_id: params[:id])
    product_price = @product.price
    [item, product_price]
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

  def create_item_in_cart_items(item, cgst, sgst, price, quantity)
    item&.update(
      quantity: quantity,
      cgst: cgst,
      sgst: sgst,
      price: price
    )
  end
end
