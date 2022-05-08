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

ActiveRecord::Schema[7.0].define(version: 2022_05_07_183039) do
  create_table "nacebels", force: :cascade do |t|
    t.integer "level"
    t.string "code"
    t.string "parentCode"
    t.string "labelNL"
    t.string "labelFR"
    t.string "labelDE"
    t.string "labelEN"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_nacebels", force: :cascade do |t|
    t.integer "request_id", null: false
    t.integer "nacebel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nacebel_id"], name: "index_request_nacebels_on_nacebel_id"
    t.index ["request_id"], name: "index_request_nacebels_on_request_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "email"
    t.string "phonenumber"
    t.string "name"
    t.string "surname"
    t.string "address"
    t.integer "annualRevenue"
    t.string "enterpriseNumber"
    t.string "legalName"
    t.boolean "naturalPerson"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "request_nacebels", "nacebels"
  add_foreign_key "request_nacebels", "requests"
end
