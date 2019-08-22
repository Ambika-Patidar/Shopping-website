class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :cart_items
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :carts, through: :cart_items 
  validates_presence_of :name, :brand, :price
  validates :user_id, :category_id, null: false
  has_one_attached :image
end
