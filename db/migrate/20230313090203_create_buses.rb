class CreateBuses < ActiveRecord::Migration[7.0]
  def change
    create_table :buses do |t|
      t.string :name,         null: false
      t.integer :type,         null: false, default: 0
      t.string :brand,         null: false
      t.integer :capacity,         null: false, default: 0

      t.timestamps
    end
  end
end
