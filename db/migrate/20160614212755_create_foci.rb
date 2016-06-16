class CreateFoci < ActiveRecord::Migration
  def change
    create_table :foci, id: :uuid do |t|
      t.uuid :context_id,	null: false
      t.uuid :snomedct_concept_id,	null: false

      t.timestamps null: false
    end
    add_index :foci, :context_id
    add_index :foci, :snomedct_concept_id
  end
end
