class AddFieldFormattedpriceToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :formattedprice, :string, default: '$0.00'
  end
end
