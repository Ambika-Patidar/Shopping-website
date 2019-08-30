# frozen_string_literal: true

# This Class used for Address Model
class Address < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates_presence_of :building_no, :area, :city, :state, :pincode
  validates_format_of :pincode, with: /\A[0-9,\s]+\z/
end
