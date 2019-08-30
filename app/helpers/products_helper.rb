# frozen_string_literal: true

# This module used for Product category
module ProductsHelper
  def product_category
    @categories.map { |c| [c.category_name, c.id] }
  end

  def number_to_currency_br(number)
    number_to_currency(number, unit: 'Rs ', separator: '.', delimiter: ',')
  end
end
