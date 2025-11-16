// Azure Service Bus queue component archetype
// Provides standard properties and tags for Service Bus queue components
// Used for modeling reliable message queuing and asynchronous communication

ServiceBusQueueComponent = component {
    description "Azure Service Bus queue for reliable message queuing"
    technology "Azure Service Bus"
    tags "Queue"
    properties {
        "component.type" "Message Queue"
        "messaging.pattern" "Point-to-Point"
        "delivery.guarantee" "At-Least-Once"
        "ordering" "FIFO"
        "dead.letter" "Supported"
        "sessions" "Supported"
        "duplicate.detection" "Supported"
        "use.cases" "Command Processing,Workflow,Decoupling"
    }
    
    perspectives {
        "Technical" "Message processing and reliability"
        "Performance" "Queue throughput and latency"
        "Operational" "Message monitoring and troubleshooting"
    }
}