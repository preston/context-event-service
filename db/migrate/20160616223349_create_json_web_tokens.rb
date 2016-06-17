class CreateJsonWebTokens < ActiveRecord::Migration
  def change
    create_table :json_web_tokens, id: :uuid do |t|
      t.uuid :identity_id,	null: false, index: true
      t.datetime :expires_at,	null: false, index: true

      t.timestamps null: false
    end
    add_foreign_key :json_web_tokens, :identities
  end
end
