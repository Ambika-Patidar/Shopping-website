class RemoveTotalTaxFromCartItem < ActiveRecord::Migration[5.2]
  def change
    remove_column :cart_items, :total_tax, :decimal
  end
end
