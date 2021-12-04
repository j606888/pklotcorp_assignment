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

ActiveRecord::Schema.define(version: 2021_12_04_065303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "order_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_order_lists_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "order_list_id", null: false
    t.integer "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_list_id"], name: "index_orders_on_order_list_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "promotion_actions", force: :cascade do |t|
    t.bigint "promotion_id", null: false
    t.string "action_type"
    t.jsonb "config"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["promotion_id"], name: "index_promotion_actions_on_promotion_id"
  end

  create_table "promotion_rules", force: :cascade do |t|
    t.bigint "promotion_id", null: false
    t.string "rule_type"
    t.jsonb "config"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["promotion_id"], name: "index_promotion_rules_on_promotion_id"
  end

  create_table "promotion_usages", force: :cascade do |t|
    t.bigint "promotion_id", null: false
    t.bigint "user_id", null: false
    t.integer "discount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["promotion_id"], name: "index_promotion_usages_on_promotion_id"
    t.index ["user_id"], name: "index_promotion_usages_on_user_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "order_lists", "users"
  add_foreign_key "orders", "order_lists"
  add_foreign_key "orders", "products"
  add_foreign_key "promotion_actions", "promotions"
  add_foreign_key "promotion_rules", "promotions"
  add_foreign_key "promotion_usages", "promotions"
  add_foreign_key "promotion_usages", "users"
end
