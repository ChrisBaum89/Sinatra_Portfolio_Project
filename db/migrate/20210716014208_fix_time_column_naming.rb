class FixTimeColumnNaming < ActiveRecord::Migration[6.0]
  def change
    rename_column :catches, :time, :updated_at
  end
end
