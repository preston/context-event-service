class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets, id: :uuid do |t|
      t.uuid :context_id,	null: false
      t.string :uri,	null: false

      t.timestamps null: false
    end
    add_index :assets, :context_id
	add_foreign_key	:assets, :contexts
  end
end
