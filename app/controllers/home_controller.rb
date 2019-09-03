# frozen_string_literal: true

# This class used to show all products at home
class HomeController < ApplicationController
  def index
    @products = if current_user
                  Product.of_other_user(current_user)
                else
                  Product.all
                end
  end
end
