class CreateInterests < ActiveRecord::Migration
    def change
        create_table :interests, id: :uuid do |t|
            t.uuid :role_id,	null: false,	index: true
            t.uuid :snomedct_concept_id,	null: false, index: true

            t.timestamps null: false
        end
    end
end
