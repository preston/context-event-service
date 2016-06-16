json.array!(@interests) do |interest|
  json.extract! interest, :id, :role_id, :code
  json.url interest_url(interest, format: :json)
end
