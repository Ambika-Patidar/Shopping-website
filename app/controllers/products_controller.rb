class ProductsController < ApplicationController
  before_action :require_login, only:[:index , :new, :edit, :create, :edit, :update,:destroy]
  helper_method :redirect_to_products_path

  def index
     @products = current_user.products
  end

  def new
    @product = Product.new
    @categories = Category.all
    @user = User.new
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def create
    @categories = Category.all
    @product = current_user.products.build(product_params)
      if @product.save
        redirect_to_products_path
      else
        render 'products/new'
      end
   end

  def edit
    @categories = Category.all
    @product = Product.find_by_id(params[:id])
  end

  def update
    @categories = Category.all
    @product = Product.find_by_id(params[:id]) 
    if @product.update(product_params)
      redirect_to_products_path
    else 
        render "products/edit"
    end
  end  

  def destroy
    @product = Product.find_by_id(params[:id])
    @product.cart_items.destroy
    @product.destroy
 
    redirect_to_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :brand, :price, :category_id, :image)
  end

  def redirect_to_products_path
    redirect_to products_path
  end
end
