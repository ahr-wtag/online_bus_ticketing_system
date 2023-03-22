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

ActiveRecord::Schema[7.0].define(version: 2023_03_22_082933) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buses", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "typed", default: "", null: false
    t.string "brand", default: "", null: false
    t.integer "capacity", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.string "origin", default: "", null: false
    t.string "destination", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seats", force: :cascade do |t|
    t.string "number"
    t.boolean "booked"
    t.bigint "bus_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "ticket_id"
    t.index ["bus_id"], name: "index_seats_on_bus_id"
    t.index ["ticket_id"], name: "index_seats_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "total_fare", null: false
    t.bigint "user_id", null: false
    t.bigint "payment_id", null: false
    t.bigint "trip_id", null: false
    t.bigint "bus_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bus_id"], name: "index_tickets_on_bus_id"
    t.index ["payment_id"], name: "index_tickets_on_payment_id"
    t.index ["trip_id"], name: "index_tickets_on_trip_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "ticket_price", default: 0, null: false
    t.integer "total_booked", default: 0, null: false
    t.date "date", default: "2023-03-22", null: false
    t.time "time", default: "2000-01-01 10:35:09", null: false
    t.bigint "bus_id", null: false
    t.bigint "route_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bus_id"], name: "index_trips_on_bus_id"
    t.index ["route_id"], name: "index_trips_on_route_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "user_name", default: "", null: false
    t.string "password", default: "", null: false
    t.string "phone", default: "", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  add_foreign_key "seats", "buses"
  add_foreign_key "seats", "tickets"
  add_foreign_key "tickets", "buses"
  add_foreign_key "tickets", "payments"
  add_foreign_key "tickets", "trips"
  add_foreign_key "tickets", "users"
  add_foreign_key "trips", "buses"
  add_foreign_key "trips", "routes"
end
