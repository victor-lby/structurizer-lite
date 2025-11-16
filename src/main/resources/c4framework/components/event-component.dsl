// Event entity component archetype
// Provides standard properties and tags for event entity components
// Used for modeling event structures and domain events

EventComponent = component {
    description "Event entity representing domain or system events"
    technology "Event Schema"
    tags "Event"
    properties {
        "component.type" "Event Entity"
        "data.structure" "Immutable"
        "timestamp" "Required"
        "causation" "Traceable"
        "correlation" "Supported"
        "replay" "Supported"
        "ordering" "Temporal"
        "use.cases" "Domain Events,System Notifications,Audit Trail"
    }
}