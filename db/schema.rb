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

ActiveRecord::Schema[7.1].define(version: 2024_04_21_100957) do
  create_table "user_accounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email"
    t.string "confirmation_token", null: false
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "encrypted_password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_user_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_user_accounts_on_email", unique: true
    t.index ["unconfirmed_email"], name: "index_user_accounts_on_unconfirmed_email", unique: true
  end

  create_table "workload_groups", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workload_points", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "workload_group_id", null: false
    t.bigint "user_account_id", null: false
    t.integer "value"
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_account_id"], name: "index_workload_points_on_user_account_id"
    t.index ["workload_group_id"], name: "index_workload_points_on_workload_group_id"
  end

  add_foreign_key "workload_points", "user_accounts"
  add_foreign_key "workload_points", "workload_groups"
end
