# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150319152523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "transactions", force: :cascade do |t|
    t.date    "source_date"
    t.string  "name"
    t.text    "note"
    t.integer "source_amount_in_pence"
    t.string  "source_type"
    t.string  "source_fit_id"
    t.string  "memo"
    t.string  "description"
    t.date    "date"
    t.string  "category"
    t.string  "original_description"
    t.string  "location"
    t.integer "account_id",             null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.string   "ofx_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
