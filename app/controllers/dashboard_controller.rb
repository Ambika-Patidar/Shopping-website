# frozen_string_literal: true

# This class used to show all products at User Dashboard
class DashboardController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @products = Product.of_other_user(current_user)
  end
end
