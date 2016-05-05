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

ActiveRecord::Schema.define(version: 20160503204520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "urn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "g5_authenticatable_users", force: true do |t|
    t.string   "email",              default: "",   null: false
    t.string   "provider",           default: "g5", null: false
    t.string   "uid",                               null: false
    t.string   "g5_access_token"
    t.integer  "sign_in_count",      default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "g5_authenticatable_users", ["email"], name: "index_g5_authenticatable_users_on_email", unique: true, using: :btree
  add_index "g5_authenticatable_users", ["provider", "uid"], name: "index_g5_authenticatable_users_on_provider_and_uid", unique: true, using: :btree

  create_table "g5_updatable_clients", force: true do |t|
    t.string   "uid"
    t.string   "urn"
    t.json     "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "g5_updatable_clients", ["name"], name: "index_g5_updatable_clients_on_name", using: :btree
  add_index "g5_updatable_clients", ["uid"], name: "index_g5_updatable_clients_on_uid", using: :btree
  add_index "g5_updatable_clients", ["urn"], name: "index_g5_updatable_clients_on_urn", using: :btree

  create_table "g5_updatable_locations", force: true do |t|
    t.string   "uid"
    t.string   "urn"
    t.string   "client_uid"
    t.json     "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "g5_updatable_locations", ["latitude"], name: "index_g5_updatable_locations_on_latitude", using: :btree
  add_index "g5_updatable_locations", ["longitude"], name: "index_g5_updatable_locations_on_longitude", using: :btree
  add_index "g5_updatable_locations", ["name"], name: "index_g5_updatable_locations_on_name", using: :btree
  add_index "g5_updatable_locations", ["uid"], name: "index_g5_updatable_locations_on_uid", using: :btree
  add_index "g5_updatable_locations", ["urn"], name: "index_g5_updatable_locations_on_urn", using: :btree

  create_table "locations", force: true do |t|
    t.string   "urn"
    t.string   "name"
    t.string   "default_number"
    t.string   "mobile_number"
    t.string   "ppc_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
  end

  create_table "number_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_numbers", force: true do |t|
    t.integer  "number_type_id"
    t.string   "number"
    t.string   "location_uid"
    t.string   "number_kind"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ppc_numbers", force: true do |t|
    t.integer  "location_id"
    t.string   "cpm_code"
    t.string   "number"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location_uid"
  end

end
