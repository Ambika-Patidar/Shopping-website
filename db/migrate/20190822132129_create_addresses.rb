class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :building_no
      t.string :area
      t.integer :city
      t.integer :state
      t.integer :pincode
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
