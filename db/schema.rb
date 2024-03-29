# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_31_190216) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "capabilities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "entity_id", null: false
    t.string "entity_type", null: false
    t.uuid "role_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["entity_id", "role_id"], name: "index_capabilities_on_entity_id_and_role_id"
    t.index ["entity_id"], name: "index_capabilities_on_entity_id"
    t.index ["role_id"], name: "index_capabilities_on_role_id"
  end

  create_table "clients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "launch_url", null: false
    t.string "icon_url"
    t.boolean "available", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_clients_on_name", unique: true
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "person_id"
    t.uuid "parent_id"
    t.uuid "next_id"
    t.string "topic_uri", null: false
    t.string "model_uri", null: false
    t.string "controller_uri"
    t.string "agent_uri"
    t.string "action_uri"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.json "parameters", default: {}, null: false
    t.integer "time_to_live", default: 0, null: false
    t.uuid "session_id"
    t.uuid "timeline_id"
    t.index ["action_uri"], name: "index_events_on_action_uri"
    t.index ["agent_uri"], name: "index_events_on_agent_uri"
    t.index ["controller_uri"], name: "index_events_on_controller_uri"
    t.index ["created_at"], name: "index_events_on_created_at"
    t.index ["model_uri"], name: "index_events_on_model_uri"
    t.index ["parent_id"], name: "index_events_on_parent_id"
    t.index ["timeline_id"], name: "index_events_on_timeline_id"
    t.index ["topic_uri"], name: "index_events_on_topic_uri"
    t.index ["updated_at"], name: "index_events_on_updated_at"
  end

  create_table "groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_groups_on_name"
  end

  create_table "identities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "person_id", null: false
    t.uuid "identity_provider_id", null: false
    t.string "sub", null: false
    t.string "iat"
    t.string "hd"
    t.string "locale"
    t.string "email"
    t.boolean "notify_via_email", default: false, null: false
    t.boolean "notify_via_sms", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "identity_providers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "issuer", null: false
    t.string "client_id", null: false
    t.string "client_secret", null: false
    t.string "alternate_client_id"
    t.json "configuration"
    t.json "public_keys"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "scopes", default: "", null: false
    t.index ["name"], name: "index_identity_providers_on_name"
  end

  create_table "members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "group_id", null: false
    t.uuid "person_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["group_id"], name: "index_members_on_group_id"
    t.index ["person_id"], name: "index_members_on_person_id"
  end

  create_table "people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "external_id"
    t.string "salutation"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["code"], name: "index_roles_on_code", unique: true
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "identity_id", null: false
    t.datetime "expires_at", precision: nil, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.uuid "timeline_id"
    t.index ["expires_at"], name: "index_sessions_on_expires_at"
    t.index ["identity_id"], name: "index_sessions_on_identity_id"
    t.index ["timeline_id"], name: "index_sessions_on_timeline_id"
  end

  create_table "timelines", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["created_at"], name: "index_timelines_on_created_at"
    t.index ["updated_at"], name: "index_timelines_on_updated_at"
  end

  add_foreign_key "capabilities", "roles"
  add_foreign_key "events", "events", column: "next_id"
  add_foreign_key "events", "events", column: "parent_id"
  add_foreign_key "events", "timelines", on_delete: :cascade
  add_foreign_key "identities", "identity_providers"
  add_foreign_key "identities", "people"
  add_foreign_key "members", "groups"
  add_foreign_key "members", "people"
  add_foreign_key "sessions", "identities"
  add_foreign_key "sessions", "timelines", on_delete: :cascade
end
