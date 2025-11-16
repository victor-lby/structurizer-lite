// Node.js microservice container archetype
// Provides standard properties and tags for Node.js microservice containers
// STATUS TAGS: Use SvcNew, SvcAlt, or SvcSame to indicate service status
MicroserviceNodeContainer = container {
    description "Node.js-based microservice container"
    technology "Node.js Express"
    tags "SvcNew"
    properties {
        "container.type" "Microservice"
        "runtime" "Node.js"
        "framework" "Express.js"
        "architecture.style" "Microservices"
        "communication" "HTTP REST,GraphQL"
        "packaging" "npm,Docker"
        "async.model" "Event-Driven"
        "use.case" "API Services,Real-time Applications,I/O Intensive"
    }
    
    perspectives {
        "Technical" "Node.js microservice architecture and performance"
        "Operational" "Container deployment and monitoring"
        "Performance" "Node.js runtime optimization and scalability"
    }
}