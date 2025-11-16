// Redis cache instance component archetype
// Provides standard properties and tags for Redis cache instances within containers
// Used for modeling in-memory data structures and caching layers

RedisInstanceComponent = component {
    description "Redis cache instance for high-performance data caching"
    technology "Redis"
    tags "Cache"
    properties {
        "component.type" "Cache Instance"
        "storage.type" "In-Memory"
        "data.structure" "Key-Value"
        "persistence" "Optional"
        "clustering" "Supported"
        "replication" "Master-Slave"
        "use.cases" "Session Storage,Caching,Pub/Sub"
    }
}