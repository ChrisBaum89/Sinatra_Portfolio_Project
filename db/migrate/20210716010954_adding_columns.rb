class AddingColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :baits, :user_id, :integer
    add_column :fishes, :catch_id, :integer
  end
end
