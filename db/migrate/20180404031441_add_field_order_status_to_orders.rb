class AddFieldOrderStatusToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :order_status, :string
  end
end
