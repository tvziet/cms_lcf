# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_03_24_073059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "administrators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "avatar"
    t.string "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.string "slug"
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_administrators_on_role_id"
    t.index ["slug"], name: "index_administrators_on_slug", unique: true
  end

  create_table "carousels", force: :cascade do |t|
    t.boolean "active", default: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "companies_name_idx", opclass: :gin_trgm_ops, using: :gin
    t.index ["slug"], name: "index_companies_on_slug", unique: true
  end

  create_table "company_employees", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_employees_on_company_id"
    t.index ["employee_id"], name: "index_company_employees_on_employee_id"
  end

  create_table "document_levels", force: :cascade do |t|
    t.string "name"
    t.integer "documents_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["name"], name: "document_levels_name_idx", opclass: :gin_trgm_ops, using: :gin
    t.index ["slug"], name: "index_document_levels_on_slug", unique: true
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "document_level_id"
    t.integer "company_id"
    t.text "group_ids", default: [], array: true
    t.integer "group_id"
    t.text "employee_ids", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["document_level_id"], name: "index_documents_on_document_level_id"
    t.index ["slug"], name: "index_documents_on_slug", unique: true
    t.index ["title"], name: "documents_title_idx", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "employees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "avatar"
    t.string "full_name"
    t.date "dob"
    t.integer "gender", default: 2
    t.string "address"
    t.string "native_place"
    t.integer "age"
    t.string "tax_code"
    t.string "social_insurance_number"
    t.text "info_contract"
    t.integer "working_status", default: 1
    t.string "job_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "group_employees", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_group_employees_on_employee_id"
    t.index ["group_id"], name: "index_group_employees_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["company_id"], name: "index_groups_on_company_id"
    t.index ["slug"], name: "index_groups_on_slug", unique: true
  end

  create_table "news", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "status", default: 0
    t.datetime "published_at"
    t.boolean "public", default: false
    t.integer "company_id"
    t.text "group_ids", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_news_on_slug", unique: true
    t.index ["title"], name: "news_title_idx", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "roles", force: :cascade do |t|
    t.integer "level", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "administrators", "roles"
  add_foreign_key "company_employees", "companies"
  add_foreign_key "company_employees", "employees"
  add_foreign_key "documents", "document_levels"
  add_foreign_key "group_employees", "employees"
  add_foreign_key "group_employees", "groups"
  add_foreign_key "groups", "companies"
end
