# frozen_string_literal: true

# This class used to show all products at home
class HomeController < ApplicationController
  layout 'login'

  def index
    @products = Product.all
  end
end
