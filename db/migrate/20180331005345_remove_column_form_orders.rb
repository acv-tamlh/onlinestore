class RemoveColumnFormOrders < ActiveRecord::Migration[5.1]
  def up
    remove_column :orders, :full_name, :string
    remove_column :orders, :email, :string
    remove_column :orders, :address, :string
    remove_column :orders, :phone, :string
  end
  def down
    add_column :orders, :full_name, :string
    add_column :orders, :email, :string
    add_column :orders, :address, :string
    add_column :orders, :phone, :string
  end
end
