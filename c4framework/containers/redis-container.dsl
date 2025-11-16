// Redis cache container archetype
// Provides standard properties and tags for Redis cache containers
// STATUS TAGS: Use DbNew, DbAlt, or DbSame to indicate database/cache status
RedisContainer = container {
    description "Redis in-memory data structure store used as cache"
    technology "Redis"
    tags "DbNew"
    properties {
        "container.type" "Cache"
        "database.type" "Key-Value Store"
        "persistence" "Optional"
        "clustering" "Supported"
        "data.structure" "String,Hash,List,Set,SortedSet"
        "use.case" "Caching,Session Store,Message Broker"
    }
    
    perspectives {
        "Performance" "Cache performance and memory optimization"
        "Operational" "Cache management and monitoring"
        "Financial" "Memory costs and resource optimization"
    }
}