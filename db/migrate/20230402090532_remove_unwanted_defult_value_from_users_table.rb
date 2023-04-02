class RemoveUnwantedDefultValueFromUsersTable < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :first_name, :string, default: nil
    change_column :users, :last_name, :string, default: nil
    change_column :users, :email, :string, default: nil
    change_column :users, :user_name, :string, default: nil
    change_column :users, :encrypted_password, :string, default: nil
    change_column :users, :phone, :string, default: nil
  
  end
end
