class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants, id: :uuid do |t|
      t.uuid :encounter_id, null: false
      t.uuid :user_id,  null: false

      t.timestamps null: false
    end
    add_foreign_key :participants,    :users
  end
end
