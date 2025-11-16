// Azure cloud service system archetype
// Defines standard properties for Azure cloud service systems
// NOTE: System archetypes are OPTIONAL extensions - use simple tags for clarity
AzureServiceSystem = softwareSystem {
    description "Azure cloud service-based system"
    tags "Azure"
    properties {
        "system.type" "Azure Cloud Service"
        "cloud.provider" "Microsoft Azure"
        "service.model" "Platform-as-a-Service"
        "management.level" "Fully Managed"
        "scaling.type" "Auto-scaling"
        "availability.model" "Multi-region"
        "tags.original" "Cloud,Service,PaaS,Managed"
    }
    
    perspectives {
        "Financial" "Cloud cost implications and ROI"
        "Technical" "Azure service maturity and integration"
        "Security" "Cloud security posture and compliance"
    }
}