class Collapse < ActiveRecord::Migration[5.1]
    def change
        enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

        create_table 'activities', id: :uuid do |t|
            t.uuid     'parent_id'
            t.string   'name', null: false
            t.text     'description'
            t.datetime 'started_at'
            t.datetime 'ended_at'
            t.string   'semantic_uri'
            t.datetime 'created_at',   null: false
            t.datetime 'updated_at',   null: false
            t.uuid     'place_id'
            t.boolean  'system', null: false
            t.uuid     'next_id'
            t.uuid     'scope_id'
        end

        add_index 'activities', ['parent_id']
        add_index 'activities', ['semantic_uri']

        create_table 'actor_roles', id: :uuid do |t|
            t.uuid     'activity_id', null: false
            t.string   'semantic_uri', null: false
            t.datetime 'created_at',   null: false
            t.datetime 'updated_at',   null: false
            t.uuid     'person_id',    null: false
        end

        add_index 'actor_roles', ['activity_id']

        create_table 'assets', id: :uuid do |t|
            t.string   'uri', null: false
            t.datetime 'created_at', null: false
            t.datetime 'updated_at', null: false
        end

        create_table 'capabilities', id: :uuid do |t|
            t.uuid     'entity_id', null: false
            t.string   'entity_type', null: false
            t.uuid     'role_id',     null: false
            t.datetime 'created_at',  null: false
            t.datetime 'updated_at',  null: false
        end

        add_index 'capabilities', %w(entity_id role_id)
        add_index 'capabilities', ['entity_id']
        add_index 'capabilities', ['role_id']

        create_table 'clients', id: :uuid do |t|
            t.string   'name',       null: false
            t.string   'launch_url', null: false
            t.string   'icon_url'
            t.boolean  'available',  null: false
            t.datetime 'created_at', null: false
            t.datetime 'updated_at', null: false
        end

        add_index 'clients', ['name'], unique: true

        create_table 'groups', id: :uuid do |t|
            t.string   'name', null: false
            t.text     'description'
            t.datetime 'created_at',  null: false
            t.datetime 'updated_at',  null: false
        end

        add_index 'groups', ['name']

        create_table 'identities', id: :uuid do |t|
            t.uuid     'person_id',                        null: false
            t.uuid     'identity_provider_id',                      null: false
            t.string   'sub',                              null: false
            t.string   'iat'
            t.string   'hd'
            t.string   'locale'
            t.string   'email'
            t.json     'jwt',              default: {},    null: false
            t.boolean  'notify_via_email', default: false, null: false
            t.boolean  'notify_via_sms',   default: false, null: false
            t.datetime 'created_at',                       null: false
            t.datetime 'updated_at',                       null: false
        end

        create_table 'identity_providers', id: :uuid do |t|
            t.string   'name',                             null: false
            t.string   'issuer',                           null: false
            t.string   'client_id',                        null: false
            t.string   'client_secret',                    null: false
            t.string   'alternate_client_id'
            t.json     'configuration'
            t.json     'public_keys'
            t.datetime 'created_at',                       null: false
            t.datetime 'updated_at',                       null: false
            t.string   'scopes', default: '', null: false
        end

        add_index 'identity_providers', ['name']

        create_table 'json_web_tokens', id: :uuid do |t|
            t.uuid     'identity_id', null: false
            t.datetime 'expires_at',  null: false
            t.datetime 'created_at',  null: false
            t.datetime 'updated_at',  null: false
        end

        add_index 'json_web_tokens', ['expires_at']
        add_index 'json_web_tokens', ['identity_id']

        create_table 'members', id: :uuid do |t|
            t.uuid     'group_id', null: false
            t.uuid     'person_id',  null: false
            t.datetime 'created_at', null: false
            t.datetime 'updated_at', null: false
        end

        add_index 'members', ['group_id']
        add_index 'members', ['person_id']

        create_table 'objectives', id: :uuid do |t|
            t.boolean  'formalized'
            t.string   'language'
            t.string   'semantic_uri'
            t.string   'specification'
            t.text     'comment'
            t.datetime 'created_at',    null: false
            t.datetime 'updated_at',    null: false
            t.uuid     'activity_id',   null: false
        end

        create_table 'people', id: :uuid do |t|
            t.string   'name', null: false
            t.string   'external_id'
            t.string   'salutation'
            t.string   'first_name'
            t.string   'middle_name'
            t.string   'last_name'
            t.datetime 'created_at',  null: false
            t.datetime 'updated_at',  null: false
        end

        create_table 'places', id: :uuid do |t|
            t.string   'name',        null: false
            t.text     'address'
            t.text     'description'
            t.datetime 'created_at',  null: false
            t.datetime 'updated_at',  null: false
        end

        create_table 'roles', id: :uuid do |t|
            t.string   'name',        null: false
            t.string   'code',        null: false
            t.text     'description'
            t.datetime 'created_at',  null: false
            t.datetime 'updated_at',  null: false
        end

        add_index 'roles', ['code'], name: 'index_roles_on_code', unique: true
        add_index 'roles', ['name'], name: 'index_roles_on_name', unique: true

        create_table 'sessions', id: :uuid do |t|
            t.uuid     'identity_id', null: false
            t.datetime 'expires_at'
            t.datetime 'created_at',  null: false
            t.datetime 'updated_at',  null: false
        end

        create_table 'usage_roles', id: :uuid do |t|
            t.uuid     'activity_id', null: false
            t.uuid     'asset_id',     null: false
            t.datetime 'created_at',   null: false
            t.datetime 'updated_at',   null: false
            t.string   'semantic_uri', null: false
        end

        add_index 'usage_roles', ['activity_id']
        add_index 'usage_roles', ['asset_id']

        add_foreign_key 'activities', 'activities', column: 'scope_id'
        add_foreign_key 'activities', 'activities', column: 'parent_id'
        add_foreign_key 'activities', 'activities', column: 'next_id'
        add_foreign_key 'activities', 'places'
        add_foreign_key 'actor_roles', 'activities'
        add_foreign_key 'capabilities', 'roles'
        add_foreign_key 'identities', 'identity_providers'
        add_foreign_key 'identities', 'people'
        add_foreign_key 'json_web_tokens', 'identities'
        add_foreign_key 'members', 'groups'
        add_foreign_key 'members', 'people'
        add_foreign_key 'objectives', 'activities'
        add_foreign_key 'usage_roles', 'activities'
        add_foreign_key 'usage_roles', 'assets'
	end
end
