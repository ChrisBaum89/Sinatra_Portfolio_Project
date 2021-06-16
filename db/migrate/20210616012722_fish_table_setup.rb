class FishTableSetup < ActiveRecord::Migration[6.0]
  def change
    create_table :fishes do |t|
      t.string :type
      t.string :length
      t.integer :weight
    end
  end
end
