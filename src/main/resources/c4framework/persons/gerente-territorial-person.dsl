// Territorial manager person archetype
// Defines standard properties for territorial manager role
// MANDATORY TAG: All persons must use "User" tag for C4 compliance
TerritorialManagerPerson = person {
    description "Territorial manager overseeing multiple regions"
    tags "User"
    properties {
        "user.type" "Territorial Manager"
        "access.level" "Territorial"
        "role.category" "Management"
        "scope" "Territorial Level"
        "responsibilities" "Territory Strategy,Regional Coordination,Performance Management"
        "role.name" "GerenteTerritorial"
    }
}