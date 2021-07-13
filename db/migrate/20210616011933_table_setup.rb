class TableSetup < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :hometown
      t.integer :age
    end
  end

  def change
    create_table :fishes do |t|
      t.string :type
      t.integer :weight
      t.integer :length
      t.integer :catch_id
    end
  end

  def change
    create_table :baits do |t|
      t.string :type
      t.string :color
      t.string :user_id
    end
  end

  def change
    create_table :catches do |t|
      t.datetime :create_time
      t.integer :bait_id
    end
  end
end
