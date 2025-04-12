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

ActiveRecord::Schema[8.0].define(version: 2025_04_12_081139) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "search_queries", force: :cascade do |t|
    t.string "query", null: false
    t.string "ip_address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_search_queries_on_created_at"
    t.index ["ip_address"], name: "index_search_queries_on_ip_address"
  end

  create_table "search_summaries", force: :cascade do |t|
    t.string "ip_address", null: false
    t.string "query", null: false
    t.integer "search_count", default: 1
    t.datetime "last_searched_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ip_address", "query"], name: "index_search_summaries_on_ip_address_and_query", unique: true
  end
end
