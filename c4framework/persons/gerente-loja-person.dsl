// Store manager person archetype
// Defines standard properties for store manager role
// MANDATORY TAG: All persons must use "User" tag for C4 compliance
StoreManagerPerson = person {
    description "Store manager responsible for daily operations"
    tags "User"
    properties {
        "user.type" "Store Manager"
        "access.level" "Operational"
        "role.category" "Management"
        "scope" "Store Level"
        "responsibilities" "Daily Operations,Staff Management,Sales"
        "role.name" "GerenteLoja"
    }
}