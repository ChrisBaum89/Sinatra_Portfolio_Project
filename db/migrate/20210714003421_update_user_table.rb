class UpdateUserTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :name , :username
    add_column :users, :password_digest, :string
  end
end
