json.array!(@results) do |result|
  json.extract! result, :id, :user_id, :ordered_at, :requested_at
  json.url result_url(result, format: :json)
end
