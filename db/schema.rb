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

ActiveRecord::Schema.define(version: 2022_07_21_081542) do

  create_table "departments", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", null: false
    t.string "manager", null: false
    t.string "via", null: false
    t.string "civico", null: false
    t.string "cap", null: false
    t.string "citta", null: false
    t.string "provincia", null: false
    t.string "latitude"
    t.string "longitude"
    t.string "dep_map"
    t.string "dep_event"
    t.text "description"
    t.integer "floors"
    t.integer "number_of_spaces"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["manager"], name: "department_manager_index", unique: true
    t.index ["name"], name: "departments_index", unique: true
    t.index ["user_id"], name: "index_departments_on_user_id"
    t.index ["via", "civico", "cap", "citta", "provincia"], name: "department_position_index", unique: true
  end

  create_table "favourite_spaces", force: :cascade do |t|
    t.integer "user_id"
    t.integer "department_id"
    t.integer "space_id"
    t.string "email", null: false
    t.string "dep_name", null: false
    t.string "typology", null: false
    t.string "space_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_favourite_spaces_on_department_id"
    t.index ["email", "dep_name", "typology", "space_name"], name: "favourite_spaces_index", unique: true
    t.index ["space_id"], name: "index_favourite_spaces_on_space_id"
    t.index ["user_id"], name: "index_favourite_spaces_on_user_id"
  end

  create_table "quick_reservations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "department_id"
    t.integer "space_id"
    t.string "email", null: false
    t.string "dep_name", null: false
    t.string "typology", null: false
    t.string "space_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_quick_reservations_on_department_id"
    t.index ["email"], name: "quick_reservations_index", unique: true
    t.index ["space_id"], name: "index_quick_reservations_on_space_id"
    t.index ["user_id"], name: "index_quick_reservations_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "department_id"
    t.integer "space_id"
    t.integer "seat_id"
    t.string "email", null: false
    t.string "dep_name", null: false
    t.string "typology", null: false
    t.string "space_name", null: false
    t.integer "floor"
    t.integer "seat_num", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.string "state", null: false
    t.string "is_sync"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_reservations_on_department_id"
    t.index ["email", "dep_name", "typology", "space_name", "seat_num", "start_date", "end_date"], name: "reservations_index", unique: true
    t.index ["seat_id"], name: "index_reservations_on_seat_id"
    t.index ["space_id"], name: "index_reservations_on_space_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "space_id"
    t.string "dep_name", null: false
    t.string "typology", null: false
    t.string "space_name", null: false
    t.integer "position", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dep_name", "typology", "space_name", "position", "start_date", "end_date", "state"], name: "seats_index", unique: true
    t.index ["space_id"], name: "index_seats_on_space_id"
  end

  create_table "spaces", force: :cascade do |t|
    t.integer "department_id"
    t.string "dep_name", null: false
    t.string "typology", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "floor"
    t.integer "number_of_seats"
    t.string "state", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dep_name", "typology", "name"], name: "spaces_index", unique: true
    t.index ["department_id"], name: "index_spaces_on_department_id"
  end

  create_table "temp_deps", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", null: false
    t.string "manager", null: false
    t.string "via", null: false
    t.string "civico", null: false
    t.string "cap", null: false
    t.string "citta", null: false
    t.string "provincia", null: false
    t.string "lat"
    t.string "lon"
    t.text "description"
    t.integer "floors"
    t.integer "number_of_spaces"
    t.string "dep_map"
    t.string "dep_event"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["manager"], name: "temp_dep_manager_index", unique: true
    t.index ["name"], name: "temp_deps_index", unique: true
    t.index ["user_id"], name: "index_temp_deps_on_user_id"
    t.index ["via", "civico", "cap", "citta", "provincia"], name: "temp_dep_position_index", unique: true
  end

  create_table "temp_sps", force: :cascade do |t|
    t.integer "temp_dep_id"
    t.string "dep_name", null: false
    t.string "typology", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "floor"
    t.integer "number_of_seats"
    t.string "state", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dep_name", "typology", "name"], name: "temp_sps_index", unique: true
    t.index ["temp_dep_id"], name: "index_temp_sps_on_temp_dep_id"
  end

  create_table "temp_week_days", force: :cascade do |t|
    t.integer "temp_dep_id"
    t.string "dep_name", null: false
    t.string "day", null: false
    t.string "state", null: false
    t.datetime "apertura", null: false
    t.datetime "chiusura", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dep_name", "day"], name: "temp_week_days_index", unique: true
    t.index ["temp_dep_id"], name: "index_temp_week_days_on_temp_dep_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.string "access_token"
    t.integer "expires_at"
    t.string "refresh_token"
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at"
    t.string "unlock_token"
    t.string "locking_reason"
    t.string "role"
    t.string "requested_manager"
    t.string "longitude"
    t.string "latitude"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "week_days", force: :cascade do |t|
    t.integer "department_id"
    t.string "dep_name", null: false
    t.string "day", null: false
    t.string "state", null: false
    t.datetime "apertura", null: false
    t.datetime "chiusura", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dep_name", "day"], name: "week_days_index", unique: true
    t.index ["department_id"], name: "index_week_days_on_department_id"
  end

end
