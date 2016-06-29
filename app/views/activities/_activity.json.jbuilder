json.extract! activity, :id, :parent_id, :name, :description, :started_at, :ended_at, :semantic_uri, :place_id, :system, :previous_id, :context_id
json.extract! activity, :created_at,	:updated_at
json.url activity_url(activity)
json.path activity_path(activity)
json.actor_roles do
	json.partial! 'actor_roles/actor_role', collection: activity.actor_roles, as: :actor_role
end
json.usage_roles do
	json.partial! 'usage_roles/usage_role', collection: activity.usage_roles, as: :usage_role
end
json.objectives do
	json.partial! 'objectives/objective', collection: activity.objectives, as: :objective
end
