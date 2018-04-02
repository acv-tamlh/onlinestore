class AddFieldPriceToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :price, :decimal, default: '0.00'
  end
end
