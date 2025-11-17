// MongoDB Atlas container archetype
// Provides standard properties and tags for MongoDB Atlas containers
// STATUS TAGS: Use DbNew, DbAlt, or DbSame to indicate database status
MongoDBAtlasContainer = container {
    description "MongoDB Atlas cloud-native document database"
    technology "MongoDB Atlas"
    tags "Database" "Unchanged"
    properties {
        "container.type" "Database"
        "database.type" "Document"
        "cloud.provider" "Multi-Cloud"
        "scaling" "Auto-Scaling"
        "consistency" "Eventual"
        "replication" "Replica Sets"
        "sharding" "Horizontal"
        "use.case" "Content Management,Catalog,Analytics"
    }
    
    perspectives {
        "Performance" "MongoDB performance and scalability"
        "Financial" "Atlas pricing and cost optimization"
        "Operational" "Database management and monitoring"
    }
}