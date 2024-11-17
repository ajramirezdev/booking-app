# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_11_17_092552) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.bigint "table_id", null: false
    t.bigint "time_slot_id", null: false
    t.date "date", null: false
    t.boolean "available", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_id"], name: "index_availabilities_on_table_id"
    t.index ["time_slot_id"], name: "index_availabilities_on_time_slot_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "table_id", null: false
    t.bigint "time_slot_id", null: false
    t.bigint "availability_id", null: false
    t.date "date"
    t.integer "number_of_people"
    t.string "status", default: "confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["availability_id"], name: "index_reservations_on_availability_id"
    t.index ["table_id"], name: "index_reservations_on_table_id"
    t.index ["time_slot_id"], name: "index_reservations_on_time_slot_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "tables", force: :cascade do |t|
    t.string "name"
    t.integer "max_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tables_on_name", unique: true
  end

  create_table "time_slots", force: :cascade do |t|
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.integer "max_tables", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "availabilities", "tables"
  add_foreign_key "availabilities", "time_slots"
  add_foreign_key "reservations", "availabilities"
  add_foreign_key "reservations", "tables"
  add_foreign_key "reservations", "time_slots"
  add_foreign_key "reservations", "users"
end
