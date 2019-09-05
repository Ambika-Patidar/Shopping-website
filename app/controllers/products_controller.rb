# frozen_string_literal: true

# This Class used to perform Product operations.
class ProductsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_product, only: %i[edit update destroy]
  helper_method :product_category
  before_action :find_categories, except: %i[destroy]
  include ProductsHelper

  def index
    @products = current_user.products
    flash[:info] = 'Your Products'
  end

  def new
    @product = current_user.products.new
  end

  def show
    @product = Product.find_by_id(params[:id])
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      flash[:info] = 'Product Successfully Saved'
      redirect_to_products_path
    else

      render 'products/new'
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      flash[:info] = 'Product Successfully Updated'
      redirect_to_products_path
    else

      render 'products/edit'
    end
  end

  def destroy
    @product.cart_items.destroy
    if @product.destroy
      flash[:info] = 'Product Successfully Deleted'
      redirect_to_products_path
    else
      flash[:danger] = 'Product Not Deleted'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :brand, :price, :category_id, :image)
  end

  def redirect_to_products_path
    redirect_to products_path
  end

  def find_product
    @product = current_user.products.find_by_id(params[:id])
  end

  def find_categories
    @categories = Category.all
  end
end
