class AddFieldDetailpageurlToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :refurl, :string
  end
end
