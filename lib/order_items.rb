# frozen_string_literal: true

# This module user for order items controller
module OrderItems
  def create_cart_item(orders)
    @cart_items.each do |cart_item|
      orders.order_items.create(quantity: cart_item.quantity,
                                cgst: cart_item.cgst,
                                sgst: cart_item.sgst,
                                price: cart_item.price,
                                product_id: cart_item.product_id)
      cart_item.destroy
    end
  end
end
