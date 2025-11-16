// Architect person archetype
// Defines standard properties for architect role
// MANDATORY TAG: All persons must use "User" tag for C4 compliance
ArchitectPerson = person {
    description "Software architect responsible for system design and architecture"
    tags "User"
    properties {
        "user.type" "Architect"
        "access.level" "Technical"
        "role.category" "Technical"
        "expertise" "System Architecture"
        "responsibilities" "Architecture Design,Technical Strategy,Standards"
        "role.name" "Arquiteto"
    }
}