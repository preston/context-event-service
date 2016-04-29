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

ActiveRecord::Schema.define(version: 20160429002455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "clients", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "launch_url", null: false
    t.string   "icon_url"
    t.boolean  "available",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "clients", ["name"], name: "index_clients_on_name", unique: true, using: :btree

  create_table "contexts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "scope"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "encounters", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "external_id"
    t.uuid     "user_id",     null: false
    t.uuid     "issue_id",    null: false
    t.uuid     "context_id",  null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "identities", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id",                          null: false
    t.uuid     "provider_id",                      null: false
    t.string   "sub",                              null: false
    t.string   "iat"
    t.string   "hd"
    t.string   "locale"
    t.string   "email"
    t.json     "jwt",              default: {},    null: false
    t.boolean  "notify_via_email", default: false, null: false
    t.boolean  "notify_via_sms",   default: false, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "issues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "external_id"
    t.uuid     "user_id",     null: false
    t.uuid     "problem_id",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "labs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "external_id"
    t.uuid     "user_id",      null: false
    t.datetime "ordered_at"
    t.datetime "requested_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "participants", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "encounter_id", null: false
    t.uuid     "user_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "problems", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "external_id"
    t.string   "name",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "providers", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",                null: false
    t.string   "issuer",              null: false
    t.string   "client_id",           null: false
    t.string   "client_secret",       null: false
    t.string   "alternate_client_id"
    t.json     "configuration"
    t.json     "public_keys"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "providers", ["name"], name: "index_providers_on_name", using: :btree

  create_table "sessions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "identity_id", null: false
    t.datetime "expires_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "external_id"
    t.string   "salutation"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "encounters", "contexts"
  add_foreign_key "encounters", "issues"
  add_foreign_key "encounters", "users"
  add_foreign_key "identities", "providers"
  add_foreign_key "identities", "users"
  add_foreign_key "issues", "problems"
  add_foreign_key "issues", "users"
  add_foreign_key "labs", "users"
  add_foreign_key "participants", "users"
end
