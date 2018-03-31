class AddFieldToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_reference :order, :users, index: true
  end
end
