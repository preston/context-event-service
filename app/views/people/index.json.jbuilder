json.extract! @people, :total_pages, :previous_page, :next_page
json.total_results @people.total_entries
json.results do
	json.partial! 'people/person', collection: @people, as: :person
end
