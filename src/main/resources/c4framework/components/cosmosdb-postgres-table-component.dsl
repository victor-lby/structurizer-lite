// CosmosDB PostgreSQL table component archetype
// Provides standard properties and tags for CosmosDB PostgreSQL table components
// Used for modeling relational data structures in CosmosDB PostgreSQL

CosmosDBPostgresTableComponent = component {
    description "CosmosDB PostgreSQL table for relational data storage"
    technology "CosmosDB PostgreSQL"
    tags "Database" "Unchanged"
    properties {
        "component.type" "Database Table"
        "storage.type" "Relational"
        "data.model" "SQL"
        "consistency" "ACID"
        "scaling" "Horizontal"
        "distribution" "Sharded"
        "backup" "Automatic"
        "geo.replication" "Multi-Region"
        "use.cases" "Transactional Data,Structured Data,OLTP"
    }
}