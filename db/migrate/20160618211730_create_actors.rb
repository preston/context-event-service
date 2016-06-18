class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors, id: :uuid do |t|
      t.uuid :activity_id,	null: false
      t.uuid :participant_id,	null: false
      t.string :semantic_uri

      t.timestamps null: false
    end
    add_index :actors, :activity_id
    add_index :actors, :participant_id
    add_index :actors, :semantic_uri
	add_foreign_key	:actors, :activities
	add_foreign_key	:actors, :participants
  end
end
