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

ActiveRecord::Schema.define(version: 20160225205210) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "entity_name",   null: false
    t.string   "email",         null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "app_store_url"
  end

  add_index "clients", ["email"], name: "index_clients_on_email", unique: true, using: :btree

  create_table "referral_codes", force: :cascade do |t|
    t.string   "code_type"
    t.string   "code"
    t.integer  "sent_count", default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "client_id",              null: false
    t.integer  "user_id"
  end

  add_index "referral_codes", ["client_id"], name: "index_referral_codes_on_client_id", using: :btree

  create_table "referral_settings", force: :cascade do |t|
    t.boolean "is_active",       default: true
    t.boolean "support_sms",     default: true
    t.boolean "support_email",   default: true
    t.string  "referral_prompt", default: "Check this out:"
    t.string  "referral_thanks", default: "You rock!"
    t.integer "client_id",                                   null: false
  end

  create_table "referrals", force: :cascade do |t|
    t.integer  "referral_code_id",                   null: false
    t.integer  "used_by",                            null: false
    t.inet     "ip"
    t.string   "event_type",       default: "click"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "referrals", ["ip"], name: "index_referrals_on_ip", using: :btree

end
