# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_16_014301) do

  create_table "baits", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.integer "user_id"
  end

  create_table "catches", force: :cascade do |t|
    t.datetime "created_at"
    t.integer "bait_id"
    t.datetime "updated_at"
  end

  create_table "fish", force: :cascade do |t|
    t.string "species"
    t.string "weight"
    t.string "length"
    t.integer "catch_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
