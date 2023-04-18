class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.integer :ticket_price,         null: false, default: 0
      t.integer :total_booked,         null: false, default: 0
      t.date :date,         null: false, default: Date.current
      t.time :time,         null: false, default: Time.current
      t.references :bus, null: true, foreign_key: true
      t.references :route, null: true, foreign_key: true

      t.timestamps
    end
  end
end
