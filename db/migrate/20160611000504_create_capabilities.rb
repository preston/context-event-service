class CreateCapabilities < ActiveRecord::Migration
    def change
        create_table :capabilities, id: :uuid do |t|
            t.uuid :entity_id,	null: false
            t.string :entity_type,	null: false
            t.uuid :role_id,	null: false

            t.timestamps null: false
        end
        add_foreign_key	:capabilities,	:roles
        add_index		:capabilities,	:entity_id
        add_index		:capabilities,	:role_id
        add_index		:capabilities,	[:entity_id, :role_id]
    end
end
