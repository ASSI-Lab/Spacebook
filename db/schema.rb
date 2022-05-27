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

ActiveRecord::Schema.define(version: 2022_05_27_150132) do

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "manager"
    t.string "via"
    t.string "civico"
    t.string "cap"
    t.string "citta"
    t.string "provincia"
    t.text "description"
    t.integer "floors"
    t.integer "spaces"
    t.integer "slot"
    t.time "apertura"
    t.time "chiusura"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favourite_spaces", force: :cascade do |t|
    t.string "email"
    t.string "department"
    t.string "typology"
    t.string "space"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "quick_reservations", force: :cascade do |t|
    t.string "email"
    t.string "department"
    t.string "typology"
    t.string "space"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.string "email"
    t.string "department"
    t.string "typology"
    t.string "space"
    t.integer "floor"
    t.integer "seat"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seats", force: :cascade do |t|
    t.string "department"
    t.string "typology"
    t.string "space"
    t.integer "position"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "spaces", force: :cascade do |t|
    t.string "department"
    t.string "typology"
    t.string "space"
    t.integer "floor"
    t.integer "seats"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.integer "roles_mask"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
