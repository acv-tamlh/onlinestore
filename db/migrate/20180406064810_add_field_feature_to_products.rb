class AddFieldFeatureToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :feature, :text
  end
end
