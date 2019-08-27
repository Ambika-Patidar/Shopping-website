module CartItemsHelper
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

  def get_item_and_price
    @cart_items = current_user.cart.cart_items
    item = @cart_items.find_by(product_id: params[:id])
    product_price = @product.price
    return item, product_price
  end
end
