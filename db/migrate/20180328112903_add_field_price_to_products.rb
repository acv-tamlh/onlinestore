class AddFieldPriceToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :price, :string
  end
end
