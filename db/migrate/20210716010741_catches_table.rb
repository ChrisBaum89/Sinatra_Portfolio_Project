class CatchesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :catches do |t|
      t.datetime :time
      t.integer :bait_id
    end
  end
end
