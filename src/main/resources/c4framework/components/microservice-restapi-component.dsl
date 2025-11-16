// Microservice REST API component archetype
// Provides standard properties and tags for microservice REST API components
// Used for modeling RESTful API endpoints and HTTP-based service interfaces

MicroserviceRestAPIComponent = component {
    description "Microservice REST API component for HTTP-based service interfaces"
    technology "REST API"
    tags "REST API"
    properties {
        "component.type" "REST API"
        "protocol" "HTTP/HTTPS"
        "api.style" "RESTful"
        "data.format" "JSON"
        "authentication" "JWT"
        "documentation" "OpenAPI/Swagger"
        "versioning" "URI/Header"
        "caching" "HTTP Caching"
        "rate.limiting" "Supported"
        "use.cases" "Service Interface,Resource Management,CRUD Operations"
    }
    
    perspectives {
        "Technical" "API design and implementation quality"
        "Performance" "API response time and throughput"
        "Security" "API security and access control"
    }
}