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

ActiveRecord::Schema.define(version: 20160604130746) do

  create_table "bets", force: :cascade do |t|
    t.string   "user1",      limit: 255
    t.string   "user2",      limit: 255
    t.string   "prop",       limit: 255
    t.float    "wager",      limit: 24
    t.string   "category",   limit: 255
    t.string   "winner",     limit: 255
    t.boolean  "paid",       limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "date",       limit: 255
    t.integer  "group_id",   limit: 4
    t.boolean  "accepted",   limit: 1
    t.integer  "proposer",   limit: 4
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer "user_id",  limit: 4
    t.integer "group_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "un",              limit: 255
    t.string   "email",           limit: 255
    t.string   "mobile",          limit: 15
    t.string   "password_digest", limit: 255
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "remember_digest", limit: 255
    t.integer  "wins",            limit: 4,   default: 0
    t.integer  "losses",          limit: 4,   default: 0
    t.float    "win_percentage",  limit: 24
    t.float    "money_won",       limit: 24,  default: 0.0
    t.float    "money_lost",      limit: 24,  default: 0.0
  end

end
