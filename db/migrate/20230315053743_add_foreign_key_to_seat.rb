class AddForeignKeyToSeat < ActiveRecord::Migration[7.0]
  def change
    add_reference :seats, :ticket, index: true, foreign_key: true
  end
end
