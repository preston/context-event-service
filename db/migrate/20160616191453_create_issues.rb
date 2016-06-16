class CreateIssues < ActiveRecord::Migration
    def change
        create_table :issues, id: :uuid do |t|
            t.uuid :user_id, null: false, index: true
            t.uuid :snomedct_concept_id, null: false, index: true

            t.timestamps null: false
        end
		add_foreign_key :issues, :users
		add_foreign_key :issues, :snomedct_concepts
    end
end
