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

ActiveRecord::Schema.define(version: 20160621172318) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "activities", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "parent_id"
    t.string   "name",         null: false
    t.text     "description"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.string   "semantic_uri"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.uuid     "place_id"
    t.boolean  "system",       null: false
    t.uuid     "previous_id"
    t.uuid     "context_id"
  end

  add_index "activities", ["parent_id"], name: "index_activities_on_parent_id", using: :btree
  add_index "activities", ["semantic_uri"], name: "index_activities_on_semantic_uri", using: :btree

  create_table "assets", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "uri",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.uuid     "concept_uri", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.uuid     "group_id"
  end

  add_index "interests", ["concept_uri"], name: "index_interests_on_concept_uri", using: :btree

  create_table "issues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id",     null: false
    t.uuid     "concept_uri", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "issues", ["concept_uri"], name: "index_issues_on_concept_uri", using: :btree
  add_index "issues", ["user_id"], name: "index_issues_on_user_id", using: :btree

  create_table "json_web_tokens", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "identity_id", null: false
    t.datetime "expires_at",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "json_web_tokens", ["expires_at"], name: "index_json_web_tokens_on_expires_at", using: :btree
  add_index "json_web_tokens", ["identity_id"], name: "index_json_web_tokens_on_identity_id", using: :btree

  create_table "members", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "group_id",   null: false
    t.uuid     "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "members", ["group_id"], name: "index_members_on_group_id", using: :btree
  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "objectives", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.boolean  "formalized"
    t.string   "language"
    t.string   "semantic_uri"
    t.string   "specification"
    t.text     "comment"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.uuid     "activity_id",   null: false
  end

  create_table "participants", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.uuid     "activity_id", null: false
  end

  add_index "participants", ["user_id"], name: "index_participants_on_user_id", using: :btree

  create_table "places", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "address"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

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

  create_table "references", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "activity_id", null: false
    t.uuid     "asset_id",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "references", ["activity_id"], name: "index_references_on_activity_id", using: :btree
  add_index "references", ["asset_id"], name: "index_references_on_asset_id", using: :btree

  create_table "responsibilities", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "activity_id",    null: false
    t.uuid     "participant_id", null: false
    t.string   "semantic_uri",   null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "responsibilities", ["activity_id"], name: "index_responsibilities_on_activity_id", using: :btree
  add_index "responsibilities", ["participant_id"], name: "index_responsibilities_on_participant_id", using: :btree

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

  add_foreign_key "activities", "activities", column: "context_id"
  add_foreign_key "activities", "activities", column: "parent_id"
  add_foreign_key "activities", "activities", column: "previous_id"
  add_foreign_key "activities", "places"
  add_foreign_key "capabilities", "roles"
  add_foreign_key "identities", "providers"
  add_foreign_key "identities", "users"
  add_foreign_key "interests", "groups"
  add_foreign_key "issues", "snomedct_concepts", column: "concept_uri"
  add_foreign_key "issues", "users"
  add_foreign_key "json_web_tokens", "identities"
  add_foreign_key "members", "groups"
  add_foreign_key "members", "users"
  add_foreign_key "objectives", "activities"
  add_foreign_key "participants", "activities"
  add_foreign_key "participants", "users"
  add_foreign_key "references", "activities"
  add_foreign_key "references", "assets"
  add_foreign_key "responsibilities", "activities"
  add_foreign_key "responsibilities", "participants"
  add_foreign_key "results", "users"
  add_foreign_key "snomedct_descriptions", "snomedct_concepts"
end
