class EventTimeline < ActiveRecord::Migration[5.2]
	def change
		add_column :events, :timeline_id, :uuid
		add_foreign_key	:events, :timelines, on_delete: :cascade
		add_index	:events, :timeline_id

		add_column :sessions, :timeline_id, :uuid
		add_foreign_key	:sessions, :timelines, on_delete: :cascade
		add_index	:sessions, :timeline_id
  end
end
