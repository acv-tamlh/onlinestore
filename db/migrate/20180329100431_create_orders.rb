class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.decimal :subtotal, precision: 12, scale: 3, default: '0.00'
      t.decimal :tax, precision: 12, scale: 3, default: '0.00'
      t.decimal :shipping, precision: 12, scale: 3, default: '0.00'
      t.decimal :total, precision: 12, scale: 3, default: '0.00'
      t.references :order_status, foreign_key: true

      t.timestamps
    end
  end
end
