class ProductsController < ApplicationController
  before_action :require_login, only:[:index , :new, :edit]

  def index
     @products = Product.all
  end

  def new
    @product = Product.new
    @categories = Category.all
    @user = User.new
  end

  def create
    @categories = Category.all
    @product = current_user.products.build(product_params)
      if @product.save
        redirect_to  products_path
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
    @product =Product.find_by_id(params[:id]) 
    if @product.update(product_params)
      redirect_to products_path
    else 
        render "products/edit"
    end
  end  

  def destroy
    @product = Product.find_by_id(params[:id])
    @product.destroy
 
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :brand, :price, :category_id, :image)
  end

  def require_login
    unless current_user  
     flash[:error] = "You must be logged in to access this section"
     redirect_to sessions_new_path
    end
  end
end
