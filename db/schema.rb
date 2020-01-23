# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_23_173706) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cashbook_categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "cashbook_entries", force: :cascade do |t|
    t.datetime "recorded_at"
    t.string "particular"
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "recorded_by_id"
    t.bigint "category_id"
    t.text "remarks"
    t.index ["category_id"], name: "index_cashbook_entries_on_category_id"
    t.index ["recorded_by_id"], name: "index_cashbook_entries_on_recorded_by_id"
  end

  create_table "cashbook_entries_color_tags", id: false, force: :cascade do |t|
    t.bigint "cashbook_entry_id", null: false
    t.bigint "color_tag_id", null: false
    t.index ["cashbook_entry_id", "color_tag_id"], name: "index_cashbook_tags"
    t.index ["color_tag_id", "cashbook_entry_id"], name: "cashbook_index_tags"
  end

  create_table "color_tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "delivery_notes", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plate_dimensions", force: :cascade do |t|
    t.string "dimension"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
  end

  create_table "plate_pricings", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "plate_dimension_id", null: false
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_plate_pricings_on_customer_id"
    t.index ["plate_dimension_id"], name: "index_plate_pricings_on_plate_dimension_id"
  end

  create_table "plate_usages", force: :cascade do |t|
    t.bigint "print_job_id"
    t.bigint "plate_dimension_id"
    t.integer "set"
    t.integer "color"
    t.integer "wastage", default: 0
    t.float "price"
    t.index ["print_job_id"], name: "index_plate_usages_on_print_job_id"
  end

  create_table "print_jobs", force: :cascade do |t|
    t.integer "ref_no"
    t.string "name"
    t.bigint "customer_id", null: false
    t.text "comments"
    t.integer "state", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "assignee_id"
    t.integer "delivery_note_no"
    t.datetime "delivered_at"
    t.datetime "printed_at"
    t.bigint "delivered_by_id"
    t.date "job_on"
    t.bigint "delivery_note_id"
    t.index ["assignee_id"], name: "index_print_jobs_on_assignee_id"
    t.index ["customer_id"], name: "index_print_jobs_on_customer_id"
    t.index ["delivered_by_id"], name: "index_print_jobs_on_delivered_by_id"
    t.index ["delivery_note_id"], name: "index_print_jobs_on_delivery_note_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "avatar"
    t.boolean "is_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "weekly_targets", force: :cascade do |t|
    t.date "start_on"
    t.integer "plate_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "cashbook_entries", "cashbook_categories", column: "category_id"
  add_foreign_key "cashbook_entries", "users", column: "recorded_by_id"
  add_foreign_key "plate_pricings", "customers"
  add_foreign_key "plate_pricings", "plate_dimensions"
  add_foreign_key "plate_usages", "plate_dimensions"
  add_foreign_key "plate_usages", "print_jobs", on_delete: :cascade
  add_foreign_key "print_jobs", "customers"
  add_foreign_key "print_jobs", "delivery_notes"
  add_foreign_key "print_jobs", "users", column: "assignee_id"
  add_foreign_key "print_jobs", "users", column: "delivered_by_id"
end
