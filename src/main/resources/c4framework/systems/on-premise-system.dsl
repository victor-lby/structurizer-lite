// On-premises system archetype
// Defines standard properties for on-premises systems
// NOTE: System archetypes are OPTIONAL extensions - use simple tags for clarity
OnPremiseSystem = softwareSystem {
    description "On-premises hosted system"
    tags "OnPremise" "Unchanged"
    properties {
        "system.type" "Legacy"
    }
    
    perspectives {
        "OnPremise" "On-premises system"
    }
}