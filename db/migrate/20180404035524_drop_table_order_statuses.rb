class DropTableOrderStatuses < ActiveRecord::Migration[5.1]
  def up
    drop_table :order_statuses
  end
  def down
    create_table :order_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
