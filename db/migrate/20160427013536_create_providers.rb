class CreateProviders < ActiveRecord::Migration
    def change
        create_table :providers, id: :uuid do |t|
            t.string :name, null: false
            t.string :issuer, null: false
            t.string :client_id, null: false
            t.string :client_secret, null: false
            t.string :alternate_client_id
            t.json :configuration
            t.json :public_keys

            t.timestamps null: false
        end
        add_index :providers, :name
    end
end
