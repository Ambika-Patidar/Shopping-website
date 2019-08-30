# frozen_string_literal: true

# This Class used for Product Category Model
class Category < ApplicationRecord
  has_many :products
end
