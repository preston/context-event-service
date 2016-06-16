class CreateResults < ActiveRecord::Migration
    def change
        create_table :results, id: :uuid do |t|
            t.uuid :user_id, null: false,	index: true
            t.datetime :ordered_at
            t.datetime :requested_at

            t.timestamps null: false
        end
        add_foreign_key :results, :users
    end
end
