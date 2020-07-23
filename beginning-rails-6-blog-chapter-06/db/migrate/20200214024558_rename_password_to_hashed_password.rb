class RenamePasswordToHashedPassword < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :password, :hashed_password
  end
end
