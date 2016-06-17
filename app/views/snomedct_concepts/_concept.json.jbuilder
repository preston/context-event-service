json.extract! concept, :id, :snomedct_id, :effective_time, :active, :module_id, :definition_status_id, :created_at, :updated_at

json.descriptions do
	json.array! concept.descriptions do |d|
		json.extract! d, :id ,:snomedct_concept_id, :snomedct_id, :effective_time, :active,:module_id, :concept_id, :language_code, :type_id, :term, :case_significance_id, :created_at, :updated_at
		json.url snomedct_concept_snomedct_description_url(concept, d)
		json.path snomedct_concept_snomedct_description_path(concept, d)
	end
end

json.url snomedct_concept_url(concept)
json.path snomedct_concept_path(concept)
