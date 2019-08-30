# frozen_string_literal: true

# This Class used for Order Model
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items
  has_many :products, through: :order_items
end
