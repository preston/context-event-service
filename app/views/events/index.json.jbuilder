json.extract! @events, :total_pages, :previous_page, :next_page, :total_entries
json.results do
	json.partial! 'events/event', collection: @events, as: :event, recurse: false
end
