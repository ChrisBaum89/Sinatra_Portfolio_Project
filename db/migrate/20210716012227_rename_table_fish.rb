class RenameTableFish < ActiveRecord::Migration[6.0]
  def change
    rename_table :fishes, :fish
  end
end
