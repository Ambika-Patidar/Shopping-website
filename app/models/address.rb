class Address < ApplicationRecord
  belongs_to :user
  has_many :orders
  
  validates_presence_of :building_no, :area, :city, :state, :pincode
  validates_format_of :city, :state, :with => /\A[a-zA-Z]+\z/
  validates_format_of :pincode, :with => /\A[0-9,\s]+\z/
end
