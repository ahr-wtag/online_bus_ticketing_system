class CreateBuses < ActiveRecord::Migration[7.0]
  def change
    create_table :buses do |t|
      t.string :name,         null: false, default: ""
      t.string :type,         null: false, default: ""
      t.string :brand,         null: false, default: ""
      t.integer :capacity,         null: false, default: 0

      t.timestamps
    end
  end
end
