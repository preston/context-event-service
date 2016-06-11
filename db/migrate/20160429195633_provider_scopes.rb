class ProviderScopes < ActiveRecord::Migration

  def change
      add_column :providers, :scopes, :string, null: false, default: ''
  end

end
