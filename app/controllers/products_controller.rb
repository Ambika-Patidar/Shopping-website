class ProductsController < ApplicationController
  before_action :require_login, only:[:index , :new, :edit, :create, :edit, :update,:destroy]
  before_action :get_product, only:[:edit, :show, :update, :destroy]
  helper_method :product_category
  include ProductsHelper

  def index
     @products = current_user.products
  end

  def new
    @product = Product.new
    @categories = Category.all
    @user = User.new
  end

  def show
  end

  def create
    @categories = Category.all
    @product = current_user.products.build(product_params)
      if @product.save
        flash[:info] = "Product Successfully Saved"
        redirect_to_products_path
      else
        render 'products/new'
      end
   end

  def edit
    @categories = Category.all
  end

  def update
    @categories = Category.all 
    if @product.update(product_params)
      flash[:info] = "Product Successfully Updated"
      redirect_to_products_path
    else 
        render "products/edit"
    end
  end  

  def destroy
    @product.cart_items.destroy
    product_destroy = @product.destroy
    if product_destroy
      flash[:info] = "Product Successfully Deleted"
      redirect_to_products_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :brand, :price, :category_id, :image)
  end

  def redirect_to_products_path
    redirect_to products_path
  end

  def get_product
    @product = Product.find(params[:id])
  end
end
