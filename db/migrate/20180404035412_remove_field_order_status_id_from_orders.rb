class RemoveFieldOrderStatusIdFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :order_status_id
  end
end
