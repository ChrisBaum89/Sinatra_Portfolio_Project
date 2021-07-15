class EditsToUserColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :age
    remove_column :users, :hometown
  end
end
