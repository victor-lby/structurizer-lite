// Azure Event Hub container archetype
// Provides standard properties and tags for Azure Event Hub containers
// STATUS TAGS: Use EbNew, EbAlt, or EbSame to indicate event broker status
EventHubContainer = container {
    description "Azure Event Hub streaming data ingestion service"
    technology "Azure Event Hub"
    tags "EbNew"
    properties {
        "container.type" "Message Broker"
        "messaging.pattern" "Publish-Subscribe"
        "cloud.provider" "Azure"
        "throughput" "High"
        "retention" "Configurable"
        "partitioning" "Multiple Partitions"
        "protocol" "AMQP,HTTP"
        "use.case" "Event Streaming,Telemetry,Log Aggregation"
    }
    
    perspectives {
        "Performance" "Event streaming throughput and latency"
        "Financial" "Event processing costs and pricing"
        "Operational" "Event monitoring and management"
    }

}