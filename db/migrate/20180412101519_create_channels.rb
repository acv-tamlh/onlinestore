class CreateChannels < ActiveRecord::Migration[5.1]
  def change
    create_table :channels do |t|
      t.string :title
      t.text :description
      t.string :thumbnails_default
      t.string :thumbnails_high

      t.timestamps
    end
  end
end
