class AddFieldToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :full_name, :string
    add_column :orders, :email, :string
    add_column :orders, :address, :string
    add_column :orders, :phone, :string
  end
end
