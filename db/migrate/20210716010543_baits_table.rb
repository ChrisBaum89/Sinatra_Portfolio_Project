class BaitsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :baits do |t|
      t.string :name
      t.string :color
    end
  end
end
