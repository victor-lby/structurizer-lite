// Regional manager person archetype
// Defines standard properties for regional manager role
// MANDATORY TAG: All persons must use "User" tag for C4 compliance
RegionalManagerPerson = person {
    description "Regional manager overseeing multiple stores in a region"
    tags "User"
    properties {
        "user.type" "Regional Manager"
        "access.level" "Regional"
        "role.category" "Management"
        "scope" "Regional Level"
        "responsibilities" "Regional Strategy,Store Performance,Team Leadership"
        "role.name" "GerenteRegional"
    }
}