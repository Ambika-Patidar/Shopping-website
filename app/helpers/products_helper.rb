module ProductsHelper
  
  def product_category
    @categories.map { |c| [c.category_name, c.id] }
  end
  
end
