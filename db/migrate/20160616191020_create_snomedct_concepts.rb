class CreateSnomedctConcepts < ActiveRecord::Migration
  def change
    create_table :snomedct_concepts, id: :uuid do |t|
      t.bigint :snomedct_id,	null: false
      t.date :effective_time,	null: false
      t.boolean :active,	null: false
      t.bigint :module_id,	null: false
      t.bigint :definition_status_id,	null: false

      t.timestamps null: false
    end
    add_index :snomedct_concepts, :snomedct_id
  end
end
