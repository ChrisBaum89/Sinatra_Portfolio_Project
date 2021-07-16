class FishesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :fishes do |t|
      t.string :species
      t.string :weight
      t.string :length
    end
  end
end
