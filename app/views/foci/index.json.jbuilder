json.array!(@foci) do |focus|
  json.extract! focus, :id, :context_id, :snomedct_id
  json.url focus_url(focus, format: :json)
end
