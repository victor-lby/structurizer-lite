// Microservice SOAP component archetype
// Provides standard properties and tags for microservice SOAP components
// Used for modeling SOAP/WSDL-based service interfaces and XML message exchanges

MicroserviceSOAPComponent = component {
    description "Microservice SOAP component for XML-based service interfaces"
    technology "SOAP/WSDL"
    tags "API" "Unchanged"
    properties {
        "component.type" "SOAP Service"
        "protocol" "HTTP/HTTPS"
        "api.style" "SOAP/WSDL"
        "data.format" "XML"
        "authentication" "WS-Security"
        "documentation" "WSDL"
        "versioning" "Namespace"
        "message.pattern" "Request-Response"
        "envelope" "SOAP 1.1/1.2"
        "use.cases" "Legacy Integration,Enterprise Service Bus,B2B Integration"
    }
    
    perspectives {
        "Technical" "WSDL design and schema validation quality"
        "Performance" "Message processing time and payload size"
        "Security" "WS-Security and message-level encryption"
    }
}
