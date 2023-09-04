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

ActiveRecord::Schema.define(version: 2023_08_30_125743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidates", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "image_url"
    t.bigint "platform_product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "selected", default: false
    t.index ["platform_product_id"], name: "index_candidates_on_platform_product_id"
  end

  create_table "platform_product_transitions", force: :cascade do |t|
    t.string "to_state", null: false
    t.text "metadata"
    t.integer "sort_key", null: false
    t.integer "platform_product_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["platform_product_id", "most_recent"], name: "index_platform_product_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["platform_product_id", "sort_key"], name: "index_platform_product_transitions_parent_sort", unique: true
  end

  create_table "platform_products", force: :cascade do |t|
    t.string "url"
    t.string "state"
    t.bigint "product_id"
    t.bigint "platform_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["platform_id"], name: "index_platform_products_on_platform_id"
    t.index ["product_id"], name: "index_platform_products_on_product_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.string "logo_url"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_audit_images", force: :cascade do |t|
    t.string "image_url"
    t.bigint "product_id"
    t.bigint "scan_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_audit_images_on_product_id"
    t.index ["scan_id"], name: "index_product_audit_images_on_scan_id"
  end

  create_table "product_audit_prices", force: :cascade do |t|
    t.float "price"
    t.bigint "product_audit_id"
    t.bigint "platform_product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["platform_product_id"], name: "index_product_audit_prices_on_platform_product_id"
    t.index ["product_audit_id"], name: "index_product_audit_prices_on_product_audit_id"
  end

  create_table "product_audit_transitions", force: :cascade do |t|
    t.string "to_state", null: false
    t.text "metadata"
    t.integer "sort_key", null: false
    t.integer "product_audit_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_audit_id", "most_recent"], name: "index_product_audit_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["product_audit_id", "sort_key"], name: "index_product_audit_transitions_parent_sort", unique: true
  end

  create_table "product_audits", force: :cascade do |t|
    t.string "image_url"
    t.bigint "product_id"
    t.bigint "scan_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_audits_on_product_id"
    t.index ["scan_id"], name: "index_product_audits_on_scan_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "scans", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "candidates", "platform_products"
  add_foreign_key "platform_product_transitions", "platform_products"
  add_foreign_key "platform_products", "platforms"
  add_foreign_key "platform_products", "products"
  add_foreign_key "product_audit_images", "products"
  add_foreign_key "product_audit_images", "scans"
  add_foreign_key "product_audit_prices", "platform_products"
  add_foreign_key "product_audit_prices", "product_audits"
  add_foreign_key "product_audit_transitions", "product_audits"
  add_foreign_key "product_audits", "products"
  add_foreign_key "product_audits", "scans"
end
