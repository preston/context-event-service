class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests, id: :uuid do |t|
      t.uuid :role_id,	null: false
      t.string :code,	null: false

      t.timestamps null: false
    end
    add_index :interests, :role_id
    add_index :interests, :code
  end
end
