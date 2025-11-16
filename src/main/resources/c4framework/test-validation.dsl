workspace "Test Validation" "Test workspace to validate Phase 3 changes" {
    !identifiers hierarchical
    
    model {
        // Test Person archetype with User tag
        customer = person "Customer" "End user" {
            tags "User"
        }
        
        // Test System archetype
        testSystem = softwareSystem "Test System" "Test system" {
            
            // Test Container archetypes with status tags
            web = container "Web App" "Web interface" "React" {
                tags "AppNew"
            }
            
            gateway = container "API Gateway" "Entry point" "Kong" {
                tags "GatewayNew"
            }
            
            api = container "Order API" "Business logic" "Java Spring Boot" {
                tags "SvcNew"
            }
            
            db = container "Database" "Data storage" "PostgreSQL" {
                tags "DbNew"
            }
            
            broker = container "Event Broker" "Messaging" "Kafka" {
                tags "EbNew"
            }
        }
        
        externalSystem = softwareSystem "External System" "Third-party" {
            tags "ExtSame"
        }
        
        // Test relationships at model level
        customer -> web "Accesses via HTTPS"
        web -> gateway "Calls API via HTTPS/REST"
        gateway -> api "Routes to via HTTP/REST"
        api -> db "Reads/writes via JDBC"
        api -> broker "Publishes events via Kafka"
        api -> externalSystem "Integrates via HTTPS/REST"
    }
    
    views {
        // C1 - System Context
        systemContext testSystem "SystemContext" "System context diagram" {
            include *
            autoLayout lr
        }
        
        // C2 - Container View
        container testSystem "Containers" "Container diagram" {
            include *
            autoLayout lr
        }
        
        styles {
            // User (Person)
            element "User" {
                shape person
                background "#7030a0"
                color "#ffffff"
                stroke "#57267b"
                strokeWidth 2
            }
            
            // Apps - New
            element "AppNew" {
                shape roundedbox
                background "#ea3e84"
                color "#ffffff"
                stroke "#c2255c"
                strokeWidth 4
            }
            
            // Apps - Altered
            element "AppAlt" {
                shape roundedbox
                background "#7030a0"
                color "#ffffff"
                stroke "#57267b"
                strokeWidth 4
            }
            
            // Apps - Same
            element "AppSame" {
                shape roundedbox
                background "#9e9e9e"
                color "#ffffff"
                stroke "#6b6b6b"
                strokeWidth 4
            }
            
            // Gateways - New
            element "GatewayNew" {
                shape hexagon
                background "#ea3e84"
                color "#ffffff"
                stroke "#c2255c"
                strokeWidth 4
            }
            
            // Gateways - Altered
            element "GatewayAlt" {
                shape hexagon
                background "#7030a0"
                color "#ffffff"
                stroke "#57267b"
                strokeWidth 4
            }
            
            // Gateways - Same
            element "GatewaySame" {
                shape hexagon
                background "#9e9e9e"
                color "#ffffff"
                stroke "#6b6b6b"
                strokeWidth 4
            }
            
            // Services - New
            element "SvcNew" {
                shape box
                background "#ea3e84"
                color "#ffffff"
                stroke "#c2255c"
                strokeWidth 4
            }
            
            // Services - Altered
            element "SvcAlt" {
                shape box
                background "#7030a0"
                color "#ffffff"
                stroke "#57267b"
                strokeWidth 4
            }
            
            // Services - Same
            element "SvcSame" {
                shape box
                background "#9e9e9e"
                color "#ffffff"
                stroke "#6b6b6b"
                strokeWidth 4
            }
            
            // Databases - New
            element "DbNew" {
                shape cylinder
                background "#ea3e84"
                color "#ffffff"
                stroke "#c2255c"
                strokeWidth 4
            }
            
            // Databases - Altered
            element "DbAlt" {
                shape cylinder
                background "#7030a0"
                color "#ffffff"
                stroke "#57267b"
                strokeWidth 4
            }
            
            // Databases - Same
            element "DbSame" {
                shape cylinder
                background "#9e9e9e"
                color "#ffffff"
                stroke "#6b6b6b"
                strokeWidth 4
            }
            
            // Event Brokers - New
            element "EbNew" {
                shape pipe
                background "#ea3e84"
                color "#ffffff"
                stroke "#c2255c"
                strokeWidth 4
            }
            
            // Event Brokers - Altered
            element "EbAlt" {
                shape pipe
                background "#7030a0"
                color "#ffffff"
                stroke "#57267b"
                strokeWidth 4
            }
            
            // Event Brokers - Same
            element "EbSame" {
                shape pipe
                background "#9e9e9e"
                color "#ffffff"
                stroke "#6b6b6b"
                strokeWidth 4
            }
            
            // External - New
            element "ExtNew" {
                shape box
                background "#ea3e84"
                color "#ffffff"
                stroke "#c2255c"
                strokeWidth 2
            }
            
            // External - Altered
            element "ExtAlt" {
                shape box
                background "#7030a0"
                color "#ffffff"
                stroke "#57267b"
                strokeWidth 2
            }
            
            // External - Same
            element "ExtSame" {
                shape box
                background "#9e9e9e"
                color "#ffffff"
                stroke "#6b6b6b"
                strokeWidth 2
            }
            
            theme default
        }
    }
}
