class CreateReferences < ActiveRecord::Migration
    def change
		# Add a layer between 'asset' and the new 'activity'.
        create_table :references, id: :uuid do |t|
            t.uuid :activity_id,	null: false
            t.uuid :asset_id,	null: false

            t.timestamps null: false
        end
        add_index :references, :activity_id
        add_index :references, :asset_id
        add_foreign_key	:references, :assets
        add_foreign_key	:references, :activities
    end
end
