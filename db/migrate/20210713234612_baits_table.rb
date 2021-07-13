class BaitsTable < ActiveRecord::Migration[6.0]
    def change
      create_table :baits do |t|
        t.string :type
        t.string :color
        t.string :user_id
      end
    end
  end
