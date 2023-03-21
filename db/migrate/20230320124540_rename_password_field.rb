class RenamePasswordField < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      change_table :users do |t|
        dir.up   { t.rename :encrypted_password, :password }
        dir.down { t.rename :password, :encrypted_password }
      end
    end
  end
end
