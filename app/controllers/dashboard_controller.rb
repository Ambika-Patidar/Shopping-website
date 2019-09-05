# frozen_string_literal: true

# This class used to show all products at User Dashboard
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
    @products = if params[:category_id].present?
                  Product.of_other_user(current_user)
                         .of_category(params[:category_id])
                else
                  Product.of_other_user(current_user)
                end
    respond_to do |format|
      format.js {}
      format.html {}
    end
  end
end
