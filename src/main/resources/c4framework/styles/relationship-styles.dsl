// Relationship styles for C4 Framework
// Aligned with arch-as-a-code C4/Structurizr DSL standards
// Source: arch-as-a-code/00-guidelines/templates/modeling/c4/styles/styles.dsl
//
// MANDATORY RULES:
// - Only use allowed color: #5a5a5a (neutral gray)
// - Three relationship types: SYNC, ASYNC, DB
// - Thickness: 3 for SYNC/ASYNC, 2 for DB
// - Routing: orthogonal for consistent layout
//
// IMPORTANT: Tags on relationships are NOT supported in Structurizr DSL
// Protocol/technology should be included in relationship DESCRIPTION, not as tags

// ============================================
// SYNCHRONOUS COMMUNICATION
// ============================================
// Protocols: HTTP, HTTPS, gRPC, GraphQL, REST
// Usage: api -> service "calls via HTTPS/REST"
relationship "SYNC" {
    dashed false
    thickness 3
    color "#5a5a5a"
    routing orthogonal
}

// ============================================
// ASYNCHRONOUS COMMUNICATION
// ============================================
// Protocols: Events, Messages, Pub/Sub, Kafka, RabbitMQ
// Usage: service -> broker "publish topic:order-created"
relationship "ASYNC" {
    dashed true
    thickness 3
    color "#5a5a5a"
    routing orthogonal
}