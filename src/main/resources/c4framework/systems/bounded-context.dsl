// Bounded Context system archetype
// Represents a DDD Bounded Context as a cohesive software system with clear boundaries
// Encapsulates domain models, business logic, and data ownership within a specific context
// NOTE: System archetypes are OPTIONAL extensions - use simple tags for clarity
BoundedContext = softwareSystem {
    description "Bounded Context - A cohesive domain boundary with its own ubiquitous language"
    tags "BoundedContext" "DDD" "Domain"
    
    properties {
        "system.type" "Bounded Context"
    }
}