class CreateUsers < ActiveRecord::Migration
    def change
        create_table :users, id: :uuid do |t|
            t.string :name, null: false
            t.string :external_id
            t.string :salutation
            t.string :first_name
            t.string :middle_name
            t.string :last_name

            t.timestamps null: false
        end
    end
end
