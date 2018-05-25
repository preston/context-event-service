class RenameJsonWebTokenToSession < ActiveRecord::Migration[5.2]
  def change
    rename_table :json_web_tokens, :sessions
    remove_column :identities, :jwt
  end
end
