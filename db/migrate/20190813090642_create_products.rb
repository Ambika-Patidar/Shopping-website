class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.decimal :price
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end
end
