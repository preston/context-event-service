if event
    json.extract! event, :id, :person_id, :session_id, :parent_id, :next_id, :topic_uri, :model_uri, 
    :controller_uri, :agent_uri, :action_uri, :place_id
    json.extract! event, :created_at,	:updated_at
    json.url event_url(event)
    json.path event_path(event)
    json.objectives do
        json.partial! 'objectives/objective', collection: event.objectives, as: :objective
    end

    if recurse
        json.parent do
            json.partial! 'events/event', event: event.parent, recurse: false
        end
        json.child_events do
            json.array! event.child_events do |a|
                json.partial! 'events/event', event: a, recurse: false
            end
        end
        json.scope do
            json.partial! 'events/event', event: event.scope, recurse: false
        end
        json.scoped_events do
            json.array! event.scoped_events do |a|
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
