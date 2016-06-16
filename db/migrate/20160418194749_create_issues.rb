class CreateIssues < ActiveRecord::Migration
    def change
        create_table :issues, id: :uuid do |t|
            t.uuid :user_id, null: false
            t.integer :snomedct_id, null: false

            t.timestamps null: false
        end
        add_foreign_key :issues, :users
    end
end
