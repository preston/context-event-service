class MoreSessionRenames < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :json_web_token_id, :session_id
  end
end
