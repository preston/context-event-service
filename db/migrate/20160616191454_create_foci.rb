class CreateFoci < ActiveRecord::Migration
  def change
    create_table :foci, id: :uuid do |t|
      t.uuid :context_id,	null: false, index: true
	  t.uuid :user_id, index: true
      t.uuid :snomedct_concept_id, index: true

      t.timestamps null: false
    end
    add_foreign_key :foci, :contexts
	add_foreign_key :foci, :users
	add_foreign_key :foci, :snomedct_concepts
  end
end
