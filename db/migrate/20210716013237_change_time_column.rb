class ChangeTimeColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :catches, :time, :created_at
    add_column :catches, :time, :updated_at
  end
end
