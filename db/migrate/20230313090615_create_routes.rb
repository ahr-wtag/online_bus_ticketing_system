class CreateRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :routes do |t|
      t.string :origin, null: false
      t.string :destination, null: false

      t.timestamps
    end
  end
end
