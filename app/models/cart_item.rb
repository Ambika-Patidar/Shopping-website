# frozen_string_literal: true

# This Class used for Cart Item Model
class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
end
