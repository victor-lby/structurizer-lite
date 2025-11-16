// CosmosDB collection component archetype
// Provides standard properties and tags for CosmosDB NoSQL collection components
// Used for modeling document-based data structures in CosmosDB

CosmosDBCollectionComponent = component {
    description "CosmosDB collection for document-based data storage"
    technology "CosmosDB NoSQL"
    tags "Document Collection"
    properties {
        "component.type" "Document Collection"
        "storage.type" "Document"
        "data.model" "JSON"
        "consistency" "Tunable"
        "scaling" "Elastic"
        "partitioning" "Automatic"
        "indexing" "Automatic"
        "geo.replication" "Multi-Master"
        "use.cases" "Document Storage,JSON Data,Flexible Schema"
    }
    
    perspectives {
        "Technical" "Document collection design and optimization"
        "Performance" "Collection performance and indexing"
        "Operational" "Collection monitoring and management"
    }
}