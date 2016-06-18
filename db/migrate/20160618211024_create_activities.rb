class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities, id: :uuid do |t|
      t.uuid :context_id,	null: false
      t.uuid :parent_id
      t.string :name,	null: false
      t.text :description
      t.datetime :started_at
      t.datetime :ended_at
      t.string :semantic_uri

      t.timestamps null: false
    end
    add_index :activities, :context_id
    add_index :activities, :parent_id
    add_index :activities, :semantic_uri

	add_foreign_key	:activities, :contexts
	add_foreign_key	:activities, :activities, column: :parent_id
  end
end
