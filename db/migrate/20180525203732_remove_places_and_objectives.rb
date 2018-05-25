class RemovePlacesAndObjectives < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :place_id
    drop_table :places
    drop_table :objectives
  end
end
