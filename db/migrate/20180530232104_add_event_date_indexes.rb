class AddEventDateIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :events, :created_at
    add_index :events, :updated_at
  end
end
