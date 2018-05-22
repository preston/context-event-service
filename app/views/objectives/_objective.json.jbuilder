json.extract! objective, :id, :event_id, :formalized, :language, :specification, :comment
json.extract! objective, :created_at,	:updated_at
json.url event_objective_url(objective.event, objective)
json.path event_objective_path(objective.event, objective)
