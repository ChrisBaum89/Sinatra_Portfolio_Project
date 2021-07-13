class TableSetup < ActiveRecord::Migration[6.0]

  def change
    create_table :catches do |t|
      t.datetime :create_time
      t.integer :bait_id
    end
  end
end
