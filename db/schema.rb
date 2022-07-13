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

ActiveRecord::Schema.define(version: 2022_07_13_134209) do

  create_table "departments", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "manager"
    t.string "via"
    t.string "civico"
    t.string "cap"
    t.string "citta"
    t.string "provincia"
    t.string "latitude"
    t.string "longitude"
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
    t.string "email"
    t.string "dep_name"
    t.string "typology"
    t.string "space_name"
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
    t.string "email"
    t.string "dep_name"
    t.string "typology"
    t.string "space_name"
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
    t.string "email"
    t.string "dep_name"
    t.string "typology"
    t.string "space_name"
    t.integer "floor"
    t.integer "seat_num"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "state"
    t.string "is_sync"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_reservations_on_department_id"
    t.index ["email", "dep_name", "typology", "space_name", "floor", "seat_num", "start_date", "end_date"], name: "reservations_index", unique: true
    t.index ["seat_id"], name: "index_reservations_on_seat_id"
    t.index ["space_id"], name: "index_reservations_on_space_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "space_id"
    t.string "dep_name"
    t.string "typology"
    t.string "space_name"
    t.integer "position"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dep_name", "typology", "space_name", "position", "start_date", "end_date", "state"], name: "seats_index", unique: true
    t.index ["space_id"], name: "index_seats_on_space_id"
  end

  create_table "site_current_dates", force: :cascade do |t|
    t.datetime "last_update"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "spaces", force: :cascade do |t|
    t.integer "department_id"
    t.string "dep_name"
    t.string "typology"
    t.string "name"
    t.text "description"
    t.integer "floor"
    t.integer "number_of_seats"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dep_name", "typology", "name"], name: "spaces_index", unique: true
    t.index ["department_id"], name: "index_spaces_on_department_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "place"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "event"
    t.string "members"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "temp_deps", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "manager"
    t.string "via"
    t.string "civico"
    t.string "cap"
    t.string "citta"
    t.string "provincia"
    t.text "description"
    t.integer "floors"
    t.integer "number_of_spaces"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["manager"], name: "temp_dep_manager_index", unique: true
    t.index ["name"], name: "temp_deps_index", unique: true
    t.index ["user_id"], name: "index_temp_deps_on_user_id"
    t.index ["via", "civico", "cap", "citta", "provincia"], name: "temp_dep_position_index", unique: true
  end

  create_table "temp_sps", force: :cascade do |t|
    t.integer "temp_dep_id"
    t.string "dep_name"
    t.string "typology"
    t.string "name"
    t.text "description"
    t.integer "floor"
    t.integer "number_of_seats"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dep_name", "typology", "name"], name: "temp_sps_index", unique: true
    t.index ["temp_dep_id"], name: "index_temp_sps_on_temp_dep_id"
  end

  create_table "temp_week_days", force: :cascade do |t|
    t.integer "temp_dep_id"
    t.string "dep_name"
    t.string "day"
    t.string "state"
    t.datetime "apertura"
    t.datetime "chiusura"
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.integer "roles_mask"
    t.string "access_token"
    t.integer "expires_at"
    t.string "refresh_token"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "week_days", force: :cascade do |t|
    t.integer "department_id"
    t.string "dep_name"
    t.string "day"
    t.string "state"
    t.datetime "apertura"
    t.datetime "chiusura"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dep_name", "day"], name: "week_days_index", unique: true
    t.index ["department_id"], name: "index_week_days_on_department_id"
  end

  add_foreign_key "tasks", "users"
end
