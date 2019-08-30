# frozen_string_literal: true

# Thid Class used for Cart Model
class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :products, through: :cart_items
end
