class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  validates_presence_of :name, :brand, :price
  validates :user_id, :category_id, null: false
  has_one_attached :image
end
