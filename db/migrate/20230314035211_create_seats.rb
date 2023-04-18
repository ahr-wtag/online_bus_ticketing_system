class CreateSeats < ActiveRecord::Migration[7.0]
  def change
    create_table :seats do |t|
      t.string :number
      t.boolean :booked
      t.references :bus, null: true, foreign_key: true
      t.references :trip, null: true, foreign_key: true

      t.timestamps
    end
  end
end
