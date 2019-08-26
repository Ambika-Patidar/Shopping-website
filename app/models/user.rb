class User < ApplicationRecord
  # Use ActiveModel has_secure_password

  has_secure_password

  has_many :products
  has_one :cart
  has_many :orders
  has_many :addresses
  
  validates_presence_of :first_name, :last_name, :email
  validates :password ,length: { minimum: 6 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails" }, uniqueness: true
  validates_format_of :first_name, :last_name, :with => /\A[a-zA-Z]+\z/
end
