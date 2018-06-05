class CreateTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :timelines, id: :uuid do |t|
      t.timestamps null: false
		end
		add_index :timelines, :created_at
		add_index :timelines, :updated_at
  end
end
