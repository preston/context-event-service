json.array!(@capabilities) do |capability|
  json.extract! capability, :id, :entity_id, :entity_type, :role_id
  json.url capability_url(capability, format: :json)
end
