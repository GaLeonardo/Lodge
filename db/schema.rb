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

ActiveRecord::Schema[7.1].define(version: 2023_11_05_023838) do
  create_table "lodge_houses", force: :cascade do |t|
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
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_methods_id", null: false
    t.integer "status"
    t.index ["payment_methods_id"], name: "index_lodge_houses_on_payment_methods_id"
    t.index ["user_id"], name: "index_lodge_houses_on_user_id"
  end

  create_table "lodge_rooms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "area"
    t.integer "number_people"
    t.integer "standard_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "lodge_houses", "payment_methods", column: "payment_methods_id"
  add_foreign_key "lodge_houses", "users"
end
