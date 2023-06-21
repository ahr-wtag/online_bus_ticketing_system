class RemoveForeignKeyFromTickets < ActiveRecord::Migration[7.0]
  def change
    remove_reference :tickets, :seat, index: true, foreign_key: true
  end
end
