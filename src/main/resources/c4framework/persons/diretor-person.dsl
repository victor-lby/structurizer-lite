// Director person archetype
// Defines standard properties for director role
// MANDATORY TAG: All persons must use "User" tag for C4 compliance
DirectorPerson = person {
    description "Director with executive authority and strategic oversight"
    tags "User"
    properties {
        "user.type" "Director"
        "access.level" "Executive"
        "role.category" "Executive"
        "scope" "Organizational Level"
        "responsibilities" "Strategic Planning,Executive Decisions,Organizational Leadership"
        "role.name" "Diretor"
    }
}