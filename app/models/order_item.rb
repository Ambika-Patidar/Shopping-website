# frozen_string_literal: true

# This Class used for Order Item Model
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
end
