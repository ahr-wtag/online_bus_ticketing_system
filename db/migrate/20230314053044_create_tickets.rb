class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.integer :total_fare, null: false
      t.references :user, null: false, foreign_key: true
      t.references :payment, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: true
      t.references :seat, null: false, foreign_key: true
      t.references :bus, null: false, foreign_key: true

      t.timestamps
    end
  end
end
