class AddFieldCurrencyToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :currency, :string, default: 'USD'
  end
end
