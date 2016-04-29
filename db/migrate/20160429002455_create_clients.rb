class CreateClients < ActiveRecord::Migration
    def change
        create_table :clients, id: :uuid do |t|
            t.string :name, null: false
            t.string :launch_url, null: false
            t.string :icon_url
            t.boolean :available, null: false

            t.timestamps null: false
        end
        add_index :clients, :name, unique: true
    end
end
