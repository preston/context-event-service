class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members, id: :uuid do |t|
      t.uuid :group_id, null: false
      t.uuid :user_id, null: false

      t.timestamps null: false
    end
    add_index :members, :group_id
    add_index :members, :user_id
	add_foreign_key :members,    :users
	add_foreign_key :members,    :groups
  end
end
