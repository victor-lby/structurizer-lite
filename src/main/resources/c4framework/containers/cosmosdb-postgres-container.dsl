// CosmosDB PostgreSQL container archetype
// Provides standard properties and tags for CosmosDB PostgreSQL containers
// STATUS TAGS: Use DbNew, DbAlt, or DbSame to indicate database status
CosmosDBPostgreSQLContainer = container {
    description "Azure CosmosDB for PostgreSQL distributed database"
    technology "Azure CosmosDB for PostgreSQL"
    tags "Database" "Unchanged"
    properties {
        "container.type" "Database"
        "database.type" "Relational"
        "cloud.provider" "Azure"
        "scaling" "Horizontal"
        "consistency" "ACID"
        "distribution" "Multi-Node"
        "compatibility" "PostgreSQL"
        "use.case" "OLTP,Analytics,Multi-Tenant"
    }
    
    perspectives {
        "Performance" "Relational database performance"
        "Financial" "Postgres pricing and cost optimization"
        "Operational" "Database management and monitoring"
    }
}