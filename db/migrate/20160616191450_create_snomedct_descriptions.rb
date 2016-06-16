class CreateSnomedctDescriptions < ActiveRecord::Migration
  def change
    create_table :snomedct_descriptions, id: :uuid do |t|
      t.uuid :snomedct_concept_id,	null: false
      t.bigint :snomedct_id,	null: false
      t.date :effective_time,	null: false
      t.boolean :active,	null: false
      t.bigint :module_id,	null: false
      t.bigint :concept_id,	null: false
      t.string :language_code,	null: false
      t.bigint :type_id,	null: false
      t.string :term,	null: false
      t.bigint :case_significance_id,	null: false

      t.timestamps null: false
    end
    add_index :snomedct_descriptions, :snomedct_concept_id
    add_index :snomedct_descriptions, :snomedct_id
	add_foreign_key :snomedct_descriptions, :snomedct_concepts
  end
end
