json.extract! @concepts, :total_pages, :previous_page, :next_page
json.total_results @concepts.total_entries
json.results do
	json.partial! 'snomedct_concepts/concept', collection: @concepts, as: :concept
end
