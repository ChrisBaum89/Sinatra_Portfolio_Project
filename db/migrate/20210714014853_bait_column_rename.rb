class BaitColumnRename < ActiveRecord::Migration[6.0]
  def change
    rename_column :baits, :type , :name
  end
end
