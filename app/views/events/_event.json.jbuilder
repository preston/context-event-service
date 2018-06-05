# frozen_string_literal: true

if event
  json.extract! event, :id, :person_id, :session_id, :parent_id, :next_id, :topic_uri, :model_uri, :timeline_id, :controller_uri, :agent_uri, :action_uri, :parameters
  # json.parameters Json.parse(event.parameters)
  json.extract! event, :created_at, :updated_at
  json.url event_url(event)
  json.path event_path(event)

  if recurse
    json.parent do
      json.partial! 'events/event', event: event.parent, recurse: false
    end
    json.child_events do
      json.array! event.child_events do |a|
        json.partial! 'events/event', event: a, recurse: false
      end
    end
    json.next do
      json.partial! 'events/event', event: event.next, recurse: false
    end
    json.previous_events do
      json.array! event.previous_events do |a|
        json.partial! 'events/event', event: a, recurse: false
      end
    end
  end
end
