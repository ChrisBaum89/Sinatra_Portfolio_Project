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
      t.string :length
      t.integer :weight
    end
  end

  def change
    create_table :locations do |t|
      t.string :type #river, lake, etc.
      t.string :name
    end
  end

  def change
    create_table :catches do |t|
      t.integer :user_id
      t.integer :fish_id
      t.integer :location_id
    end
  end

end
