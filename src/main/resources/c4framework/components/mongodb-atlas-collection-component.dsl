// MongoDB Atlas collection component archetype
// Provides standard properties and tags for MongoDB Atlas collection components
// Used for modeling document-based data structures in MongoDB Atlas

MongoDBAtlasCollectionComponent = component {
    description "MongoDB Atlas collection for document-based data storage"
    technology "MongoDB Atlas"
    tags "Database" "Unchanged"
    properties {
        "component.type" "Document Collection"
        "storage.type" "Document"
        "data.model" "BSON"
        "consistency" "Eventual"
        "scaling" "Horizontal"
        "sharding" "Automatic"
        "indexing" "Flexible"
        "replication" "Replica Sets"
        "use.cases" "Document Storage,Content Management,Catalog Data"
    }
}