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

ActiveRecord::Schema[7.1].define(version: 2023_11_18_132452) do
  create_table "lodges", force: :cascade do |t|
    t.string "corporate_name"
    t.string "brand_name"
    t.string "registration_number"
    t.string "full_address"
    t.string "city"
    t.string "state"
    t.string "email"
    t.string "zip_code"
    t.string "contact_number"
    t.string "description"
    t.integer "pets"
    t.string "terms_of_service"
    t.string "check_in"
    t.string "check_out"
    t.integer "status"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lodges_on_user_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.integer "lodge_id", null: false
    t.boolean "bank_transfer"
    t.boolean "credit_card"
    t.boolean "debit_card"
    t.boolean "cash"
    t.boolean "deposit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lodge_id"], name: "index_payment_methods_on_lodge_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "total_price"
    t.integer "status"
    t.integer "number_guests"
    t.integer "user_id"
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_reservations_on_room_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "area"
    t.integer "max_people"
    t.integer "standard_price"
    t.integer "lodge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lodge_id"], name: "index_rooms_on_lodge_id"
  end

  create_table "seasonal_prices", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.integer "price"
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_seasonal_prices_on_room_id"
  end

  create_table "services", force: :cascade do |t|
    t.boolean "has_bathroom"
    t.boolean "has_balcony"
    t.boolean "has_air_conditioner"
    t.boolean "has_tv"
    t.boolean "has_closet"
    t.boolean "has_vault"
    t.boolean "is_accessible"
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_services_on_room_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "lodges", "users"
  add_foreign_key "payment_methods", "lodges"
  add_foreign_key "reservations", "rooms"
  add_foreign_key "reservations", "users"
  add_foreign_key "rooms", "lodges"
  add_foreign_key "seasonal_prices", "rooms"
  add_foreign_key "services", "rooms"
end
