# frozen_string_literal: true

# This class used to show all products at User Dashboard
class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @products = Product.of_other_user(current_user)
  end
end
