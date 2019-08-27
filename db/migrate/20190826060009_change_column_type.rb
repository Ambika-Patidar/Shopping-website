 # frozen_string_literal: true.
class ChangeColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column :addresses, :city, :string
    change_column :addresses, :state, :string
  end
end
