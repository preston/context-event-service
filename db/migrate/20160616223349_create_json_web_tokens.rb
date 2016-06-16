class CreateJsonWebTokens < ActiveRecord::Migration
  def change
    create_table :json_web_tokens do |t|
      t.uuid :user_id
      t.datetime :expires_at

      t.timestamps null: false
    end
    add_index :json_web_tokens, :user_id
    add_index :json_web_tokens, :expires_at
  end
end
