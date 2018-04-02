class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :asin
      t.string :title
      t.string :artist

      t.timestamps
    end
  end
end
