// Azure Service Bus container archetype
// Provides standard properties and tags for Azure Service Bus containers
// STATUS TAGS: Use EbNew, EbAlt, or EbSame to indicate event broker status
ServiceBusContainer = container {
    description "Azure Service Bus enterprise messaging service"
    technology "Azure Service Bus"
    tags "Queue" "Unchanged"
    properties {
        "container.type" "Message Broker"
        "messaging.pattern" "Queue,Publish-Subscribe"
        "cloud.provider" "Azure"
        "reliability" "At-Least-Once"
        "ordering" "FIFO Support"
        "transactions" "Supported"
        "protocol" "AMQP,HTTP"
        "use.case" "Decoupling,Workflow,Integration"
    }
    
    perspectives {
        "Performance" "Message processing throughput and latency"
        "Operational" "Message management and monitoring"
        "Financial" "Messaging costs and pricing optimization"
    }
}