// Azure Key Vault container archetype
// Provides standard properties and tags for Azure Key Vault containers
// STATUS TAGS: Use ExtNew, ExtAlt, or ExtSame to indicate external service status
KeyVaultContainer = container {
    description "Azure Key Vault secrets and key management service"
    technology "Azure Key Vault"
    tags "ExtNew"
    properties {
        "container.type" "Security Service"
        "security.function" "Key Management,Secret Storage"
        "cloud.provider" "Azure"
        "encryption" "Hardware Security Module"
        "access.control" "RBAC,Access Policies"
        "compliance" "FIPS 140-2,Common Criteria"
        "integration" "Azure AD"
        "use.case" "Secret Management,Certificate Management,Key Storage"
    }
    
    perspectives {
        "Security" "Secret management and encryption"
        "Operational" "Certificate lifecycle management"
        "Compliance" "Key management and audit requirements"
    }
}