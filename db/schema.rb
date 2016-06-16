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

ActiveRecord::Schema.define(version: 20160616191454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "capabilities", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "entity_id",   null: false
    t.string   "entity_type", null: false
    t.uuid     "role_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "capabilities", ["entity_id", "role_id"], name: "index_capabilities_on_entity_id_and_role_id", using: :btree
  add_index "capabilities", ["entity_id"], name: "index_capabilities_on_entity_id", using: :btree
  add_index "capabilities", ["role_id"], name: "index_capabilities_on_role_id", using: :btree

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
    t.string   "purpose"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foci", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "context_id",          null: false
    t.uuid     "user_id"
    t.uuid     "snomedct_concept_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "foci", ["context_id"], name: "index_foci_on_context_id", using: :btree
  add_index "foci", ["snomedct_concept_id"], name: "index_foci_on_snomedct_concept_id", using: :btree
  add_index "foci", ["user_id"], name: "index_foci_on_user_id", using: :btree

  create_table "groups", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "groups", ["name"], name: "index_groups_on_name", unique: true, using: :btree

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

  create_table "interests", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "role_id",             null: false
    t.uuid     "snomedct_concept_id", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "interests", ["role_id"], name: "index_interests_on_role_id", using: :btree
  add_index "interests", ["snomedct_concept_id"], name: "index_interests_on_snomedct_concept_id", using: :btree

  create_table "issues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id",             null: false
    t.uuid     "snomedct_concept_id", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "issues", ["snomedct_concept_id"], name: "index_issues_on_snomedct_concept_id", using: :btree
  add_index "issues", ["user_id"], name: "index_issues_on_user_id", using: :btree

  create_table "members", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "group_id",   null: false
    t.uuid     "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "members", ["group_id"], name: "index_members_on_group_id", using: :btree
  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "participants", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "context_id", null: false
    t.uuid     "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "participants", ["context_id"], name: "index_participants_on_context_id", using: :btree
  add_index "participants", ["user_id"], name: "index_participants_on_user_id", using: :btree

  create_table "providers", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",                             null: false
    t.string   "issuer",                           null: false
    t.string   "client_id",                        null: false
    t.string   "client_secret",                    null: false
    t.string   "alternate_client_id"
    t.json     "configuration"
    t.json     "public_keys"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "scopes",              default: "", null: false
  end

  add_index "providers", ["name"], name: "index_providers_on_name", using: :btree

  create_table "results", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id",      null: false
    t.datetime "ordered_at"
    t.datetime "requested_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "results", ["user_id"], name: "index_results_on_user_id", using: :btree

  create_table "roles", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "code",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "roles", ["code"], name: "index_roles_on_code", unique: true, using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "sessions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "identity_id", null: false
    t.datetime "expires_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "snomedct_concepts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "snomedct_id",          limit: 8, null: false
    t.date     "effective_time",                 null: false
    t.boolean  "active",                         null: false
    t.integer  "module_id",            limit: 8, null: false
    t.integer  "definition_status_id", limit: 8, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "snomedct_concepts", ["snomedct_id"], name: "index_snomedct_concepts_on_snomedct_id", using: :btree

  create_table "snomedct_descriptions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "snomedct_concept_id",            null: false
    t.integer  "snomedct_id",          limit: 8, null: false
    t.date     "effective_time",                 null: false
    t.boolean  "active",                         null: false
    t.integer  "module_id",            limit: 8, null: false
    t.integer  "concept_id",           limit: 8, null: false
    t.string   "language_code",                  null: false
    t.integer  "type_id",              limit: 8, null: false
    t.text     "term",                           null: false
    t.integer  "case_significance_id", limit: 8, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "snomedct_descriptions", ["snomedct_concept_id"], name: "index_snomedct_descriptions_on_snomedct_concept_id", using: :btree
  add_index "snomedct_descriptions", ["snomedct_id"], name: "index_snomedct_descriptions_on_snomedct_id", using: :btree

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

  add_foreign_key "capabilities", "roles"
  add_foreign_key "foci", "contexts"
  add_foreign_key "foci", "snomedct_concepts"
  add_foreign_key "foci", "users"
  add_foreign_key "identities", "providers"
  add_foreign_key "identities", "users"
  add_foreign_key "issues", "snomedct_concepts"
  add_foreign_key "issues", "users"
  add_foreign_key "members", "groups"
  add_foreign_key "members", "users"
  add_foreign_key "participants", "contexts"
  add_foreign_key "participants", "users"
  add_foreign_key "results", "users"
  add_foreign_key "snomedct_descriptions", "snomedct_concepts"
end
