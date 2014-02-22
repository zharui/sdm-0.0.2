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

ActiveRecord::Schema.define(version: 20140222100505) do

  create_table "ad_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channels", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "state_id"
    t.integer  "publisher_id"
    t.integer  "tag_ids",      default: [], array: true
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "channels", ["name"], name: "index_channels_on_name", unique: true, using: :btree
  add_index "channels", ["publisher_id"], name: "index_channels_on_publisher_id", using: :btree

  create_table "dimensions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formats", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "layouts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "state_id"
    t.integer  "publisher_id"
    t.integer  "channel_id"
    t.integer  "tag_ids",      default: [], array: true
    t.integer  "material_id"
    t.integer  "layout_id"
    t.integer  "dimension_id"
    t.integer  "format_id"
    t.integer  "serving_id"
    t.integer  "payment_id"
    t.string   "size"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "adtype_id"
  end

  add_index "positions", ["channel_id"], name: "index_positions_on_channel_id", using: :btree
  add_index "positions", ["name"], name: "index_positions_on_name", using: :btree
  add_index "positions", ["publisher_id"], name: "index_positions_on_publisher_id", using: :btree

  create_table "publishers", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "state_id"
    t.integer  "tag_ids",    default: [], array: true
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publishers", ["name"], name: "index_publishers_on_name", unique: true, using: :btree

  create_table "serving_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
