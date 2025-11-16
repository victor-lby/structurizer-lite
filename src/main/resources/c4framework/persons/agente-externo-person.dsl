// External agent person archetype
// Defines standard properties for external agent role
// MANDATORY TAG: All persons must use "User" tag for C4 compliance
AgenteExternoPerson = person {
    description "External agent or system acting on behalf of external entities"
    tags "User"
    properties {
        "user.type" "External Agent"
        "access.level" "API"
        "role.category" "External"
        "interaction.mode" "Automated"
        "relationship" "External Integration"
        "role.name" "AgenteExterno"
    }
}