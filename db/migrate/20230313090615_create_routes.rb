class CreateRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :routes do |t|
      t.string :origin,         null: false, default: ""
      t.string :destination,         null: false, default: ""

      t.timestamps
    end
  end
end
