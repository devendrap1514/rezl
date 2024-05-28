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

ActiveRecord::Schema[7.0].define(version: 2024_05_27_131156) do
  create_table "account_property_terms", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "property_term_and_conditions_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_property_terms_on_account_id"
    t.index ["property_term_and_conditions_id"], name: "index_account_property_terms_on_property_term_and_conditions_id"
  end

  create_table "account_terms", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "term_and_condition_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_terms_on_account_id"
    t.index ["term_and_condition_id"], name: "index_account_terms_on_term_and_condition_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_terms", force: :cascade do |t|
    t.integer "admin_user_id", null: false
    t.integer "term_and_condition_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_admin_terms_on_admin_user_id"
    t.index ["term_and_condition_id"], name: "index_admin_terms_on_term_and_condition_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.string "calendly_token"
    t.string "organization"
    t.string "me_uri"
    t.string "webhook_uuid"
    t.string "creator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "property_term_and_conditions", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_property_term_and_conditions_on_property_id"
  end

  create_table "term_and_conditions", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tours", force: :cascade do |t|
    t.string "uri"
    t.string "event_name"
    t.string "status"
    t.datetime "start_time"
    t.string "invitee_first_name"
    t.string "invitee_last_name"
    t.string "event_status"
    t.string "reschedule_url"
    t.string "phone_number"
    t.integer "property_id"
    t.string "timezone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_tours_on_property_id"
  end

  add_foreign_key "account_property_terms", "accounts"
  add_foreign_key "account_property_terms", "property_term_and_conditions", column: "property_term_and_conditions_id"
  add_foreign_key "account_terms", "accounts"
  add_foreign_key "account_terms", "term_and_conditions"
  add_foreign_key "admin_terms", "admin_users"
  add_foreign_key "admin_terms", "term_and_conditions"
  add_foreign_key "property_term_and_conditions", "properties"
end
