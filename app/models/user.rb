# frozen_string_literal: true

# This class Used for User Model
class User < ApplicationRecord
  after_create :initial_create_cart

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products
  has_one :cart
  has_many :orders
  has_many :addresses

  validates_presence_of :first_name, :last_name, :email
  validates :password, length: { minimum: 6 }
  validates :email, format: {
    with: URI::MailTo::EMAIL_REGEXP, message: 'only allows valid emails'
  },
                    uniqueness: true

  private

  def initial_create_cart
    create_cart(total_price: 0)
  end
end
