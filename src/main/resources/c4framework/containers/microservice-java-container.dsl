// Java microservice container archetype
// Provides standard properties and tags for Java microservice containers
// STATUS TAGS: Use SvcNew, SvcAlt, or SvcSame to indicate service status
MicroserviceJavaContainer = container {
    description "Java-based microservice container"
    technology "Java Spring Boot"
    tags "Microservice" "Unchanged"
    properties {
        "container.type" "Microservice"
        "runtime" "JVM"
        "framework" "Spring Boot"
        "architecture.style" "Microservices"
        "communication" "HTTP REST,gRPC"
        "packaging" "JAR,Docker"
        "monitoring" "Actuator,Micrometer"
        "use.case" "Business Logic,API Services,Data Processing"
    }
    
    perspectives {
        "Technical" "Java microservice architecture and performance"
        "Operational" "Container deployment and monitoring"
        "Performance" "JVM tuning and resource optimization"
    }
}