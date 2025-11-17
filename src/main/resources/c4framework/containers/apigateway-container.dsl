// API Gateway container archetype
// Provides standard properties and tags for API Gateway containers
// STATUS TAGS: Use GatewayNew, GatewayAlt, or GatewaySame to indicate gateway status
APIGatewayContainer = container "API Gateway" {
    description "API Gateway for routing and managing API requests"
    technology "Axway"
    tags "API" "Unchanged"
    properties {
        "container.type" "API Gateway"
        "function" "Request Routing,Load Balancing"
        "security" "Authentication,Authorization,Rate Limiting"
        "protocols" "HTTP,HTTPS,WebSocket"
        "features" "Caching,Transformation,Monitoring"
        "deployment" "Cloud,On-Premises,Hybrid"
        "use.case" "API Management,Microservices Gateway,Security Enforcement"
    }
    
    perspectives {
        "Operational" "API management and traffic handling"
        "Security" "Gateway security and access control"
        "Performance" "Throughput and latency characteristics"
    }
}