class AddFieldPaymentToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :token_payment, :string
    add_column :orders, :payer_id, :string
    add_column :orders, :payment_id, :string
  end
end
