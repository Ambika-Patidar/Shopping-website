# frozen_string_literal: true

# This Class Used for Product Model
class Product < ApplicationRecord
  before_update :check_price, if: :price_changed?

  belongs_to :category
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :carts, through: :cart_items

  validates_presence_of :name, :brand, :price
  validates :user_id, :category_id, null: false
  has_one_attached :image

  scope :of_other_user, ->(current_user) { where.not(user_id: current_user.id) }

  def check_price
    cart_items = CartItem.all
    price = self.price
    cart_items.each do |cart_item|
      quantity = cart_item.quantity
      cgst = price * 0.02 * quantity
      sgst = price * 0.02 * quantity
      price = price * quantity + cgst + sgst
      cart_item.update(cgst: cgst, sgst: sgst, price: price)
    end
  end
end
