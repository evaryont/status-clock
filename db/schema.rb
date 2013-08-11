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

ActiveRecord::Schema.define(version: 20130811110158) do

  create_table "clocks", force: true do |t|
    t.integer  "users_id"
    t.integer  "statuses_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clocks", ["statuses_id"], name: "index_clocks_on_statuses_id"
  add_index "clocks", ["users_id"], name: "index_clocks_on_users_id"

  create_table "statuses", force: true do |t|
    t.string   "text"
    t.integer  "lcd"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "clock_id"
  end

  add_index "statuses", ["clock_id"], name: "index_statuses_on_clock_id"
  add_index "statuses", ["user_id"], name: "index_statuses_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
    t.datetime "expires_at"
    t.integer  "status_id"
    t.integer  "hand"
    t.integer  "clock_id"
    t.string   "refresh_token"
  end

  add_index "users", ["clock_id"], name: "index_users_on_clock_id"
  add_index "users", ["status_id"], name: "index_users_on_status_id"

end
