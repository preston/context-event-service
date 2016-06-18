class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives, id: :uuid do |t|
      t.uuid :context_id,	null: false
      t.boolean :formalized
      t.string :language
      t.string :semantic_uri
      t.string :specification
      t.text :comment

      t.timestamps null: false
    end
    add_index :objectives, :context_id
	add_foreign_key	:objectives, :contexts
  end
end
