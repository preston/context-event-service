class CreateResponsibilities < ActiveRecord::Migration
  def change
    create_table :responsibilities, id: :uuid  do |t|
      t.uuid :activity_id,	null: false
      t.uuid :participant_id,	null: false
      t.string :semantic_uri,	null: false

      t.timestamps null: false
    end
    add_index :responsibilities, :activity_id
    add_index :responsibilities, :participant_id
	add_foreign_key	:responsibilities, :activities
	add_foreign_key	:responsibilities, :participants

	drop_table :actors do end
  end
end
