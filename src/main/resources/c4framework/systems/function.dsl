// Function system archetype
// Represents a DDD Function as a cohesive software system with clear boundaries
// Encapsulates domain models, business logic, and data ownership within a specific context
// NOTE: System archetypes are OPTIONAL extensions - use simple tags for clarity
Function = softwareSystem {
    description "Function - A cohesive domain boundary with its own ubiquitous language"
    tags "Function" "DDD" "Domain" "Unchanged"
    
    properties {
        "system.type" "Function"
    }
}