class CreateFoci < ActiveRecord::Migration
  def change
    create_table :foci, id: :uuid do |t|
      t.uuid :context_id,	null: false
      t.integer :snomedct_id,	null: false

      t.timestamps null: false
    end
    add_index :foci, :context_id
    add_index :foci, :snomedct_id
  end
end
