class RemoveSessionsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :sessions
    add_column :events, :json_web_token_id, :uuid
    remove_column :events, :session_id
  end
end
