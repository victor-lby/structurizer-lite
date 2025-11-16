// Customer person archetype
// Defines standard properties for customer role
// MANDATORY TAG: All persons must use "User" tag for C4 compliance
CustomerPerson = person {
    description "Customer using products or services"
    tags "User"
    properties {
        "user.type" "Customer"
        "access.level" "Standard"
        "role.category" "Customer"
        "interaction.mode" "Self-Service"
        "relationship" "External Customer"
        "role.name" "Cliente"
    }
}