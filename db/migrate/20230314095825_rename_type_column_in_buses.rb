class RenameTypeColumnInBuses < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      change_table :buses do |t|
        direction.up   { t.rename :type, :typed }
        direction.down { t.rename :typed, :type }
      end
    end
  end
end
