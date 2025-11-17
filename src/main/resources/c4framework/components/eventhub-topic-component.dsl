// Azure Event Hub topic component archetype
// Provides standard properties and tags for Event Hub topic components
// Used for modeling event streaming and real-time data ingestion

EventHubTopicComponent = component {
    description "Azure Event Hub topic for event streaming and data ingestion"
    technology "Azure Event Hub"
    tags "Topic" "Unchanged"
    properties {
        "component.type" "Event Topic"
        "messaging.pattern" "Publish-Subscribe"
        "data.format" "Event Stream"
        "throughput" "High"
        "retention" "Configurable"
        "partitioning" "Multiple Partitions"
        "ordering" "Per-Partition"
        "use.cases" "Event Streaming,Telemetry,Log Aggregation"
    }
}