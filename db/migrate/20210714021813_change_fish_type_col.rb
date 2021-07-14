class ChangeFishTypeCol < ActiveRecord::Migration[6.0]
  def change
    rename_column :fishes, :type , :species
  end
end
