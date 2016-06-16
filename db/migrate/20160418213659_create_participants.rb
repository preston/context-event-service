class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants, id: :uuid do |t|
      t.uuid :context_id, null: false, index: true
      t.uuid :user_id,  null: false, index: true

      t.timestamps null: false
    end
	add_foreign_key :participants,    :contexts
	add_foreign_key :participants,    :users
  end
end
