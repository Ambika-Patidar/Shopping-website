class User < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email
  validates :password ,length: { minimum: 6 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails" }
  has_secure_password
  validates_format_of :first_name, :last_name, :with => /\A[a-zA-Z]+\z/
end
