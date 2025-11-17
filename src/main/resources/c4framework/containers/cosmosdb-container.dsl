// CosmosDB NoSQL container archetype
// Provides standard properties and tags for CosmosDB NoSQL containers
// STATUS TAGS: Use DbNew, DbAlt, or DbSame to indicate database status
CosmosDBContainer = container {
    description "Azure CosmosDB multi-model NoSQL database"
    technology "Azure CosmosDB"
    tags "Database" "Unchanged"
    properties {
        "container.type" "Database"
        "database.type" "NoSQL"
        "cloud.provider" "Azure"
        "scaling" "Global"
        "consistency" "Tunable" 
        "apis" "SQL,MongoDB,Cassandra,Gremlin,Table"
        "distribution" "Multi-Region"
        "use.case" "Web,Mobile,Gaming,IoT"
    }
    
    perspectives {
        "Performance" "Database performance and scalability"
        "Financial" "Storage costs and pricing model"
        "Operational" "Database administration and monitoring"
    }
}