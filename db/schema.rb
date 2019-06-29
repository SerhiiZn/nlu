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

ActiveRecord::Schema.define(version: 20190629152831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analizes", force: :cascade do |t|
    t.bigint "site_data_id"
    t.json "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_data_id"], name: "index_analizes_on_site_data_id"
  end

  create_table "site_data", force: :cascade do |t|
    t.string "url"
    t.integer "rank"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "analizes", "site_data", column: "site_data_id"
end
