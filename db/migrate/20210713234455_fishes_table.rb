class FishesTable < ActiveRecord::Migration[6.0]
    def change
      create_table :fishes do |t|
        t.string :type
        t.integer :weight
        t.integer :length
        t.integer :catch_id
      end
    end
  end
