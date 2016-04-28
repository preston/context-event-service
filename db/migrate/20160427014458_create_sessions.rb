class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions, id: :uuid do |t|
      t.uuid :identity_id, null: false
      t.datetime :expires_at

      t.timestamps null: false
    end
  end
end
