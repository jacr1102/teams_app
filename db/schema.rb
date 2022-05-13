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

ActiveRecord::Schema.define(version: 2022_05_13_005457) do

  create_table "accounts", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "client_name"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "logs", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "account_from_id"
    t.bigint "account_to_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_from_id"], name: "index_logs_on_account_from_id"
    t.index ["account_to_id"], name: "index_logs_on_account_to_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "profiles", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "english_level"
    t.text "technical_experience"
    t.string "cv_link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "roles", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "team_members", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_team_members_on_account_id"
    t.index ["user_id"], name: "index_team_members_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.string "email", null: false
    t.string "username", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["first_name", "last_name"], name: "index_users_on_first_name_and_last_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "logs", "accounts", column: "account_from_id"
  add_foreign_key "logs", "accounts", column: "account_to_id"
  add_foreign_key "logs", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "team_members", "accounts"
  add_foreign_key "team_members", "users"
  add_foreign_key "users", "roles"
end
