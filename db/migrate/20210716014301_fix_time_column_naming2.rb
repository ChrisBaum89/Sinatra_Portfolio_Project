class FixTimeColumnNaming2 < ActiveRecord::Migration[6.0]
  def change
    remove_column :catches, :updated_at
    add_column :catches, :updated_at, :datetime
  end
end
