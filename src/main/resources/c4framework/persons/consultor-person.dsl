// Consultant person archetype
// Defines standard properties for consultant role
// MANDATORY TAG: All persons must use "User" tag for C4 compliance
ConsultorPerson = person {
    description "Business consultant providing advisory services"
    tags "User"
    properties {
        "user.type" "Consultant"
        "access.level" "Advisory"
        "role.category" "Business"
        "interaction.mode" "Consultative"
        "expertise" "Business Strategy"
        "role.name" "Consultor"
    }
}