# C4 Framework Documentation

## Overview

The C4 Framework is a comprehensive Structurizr DSL-based template system that provides reusable archetypes for C4 modeling. This framework enables software architects to create consistent, standardized architectural models using predefined templates for persons, software systems, containers, components, and infrastructure elements.

## Key Features

- **Reusable Archetypes**: Predefined templates for common architectural patterns
- **Hierarchical Organization**: Structured folder system for easy navigation and maintenance
- **Consistent Styling**: Standardized visual themes and element styles
- **Centralized Terminology**: Unified language and definitions across all models
- **Extensible Design**: Framework can be extended with custom domain-specific archetypes
- **Infrastructure Modeling**: Support for deployment environments and infrastructure patterns

## Framework Structure

```
c4framework/
├── workspace.dsl                    # Main framework workspace with all archetypes
├── persons/                         # Person archetype definitions
├── systems/                         # Software system archetype definitions
├── containers/                      # Container archetype definitions
├── components/                      # Component archetype definitions
├── custom-archetypes/              # Domain-specific archetype definitions
├── styles/                         # Element and relationship styling
├── themes/                         # Structurizr theme files
├── terminology/                    # Centralized terminology definitions
└── docs/                          # Framework documentation and ADRs
```

## Quick Start

### 1. Basic Usage

To use the C4 Framework, extend the main workspace in your DSL file:

```dsl
workspace extends "c4framework/workspace.dsl" {
    model {
        // Use person archetypes
        customer = person "Customer" "consultor-person" {
            description "Business consultant using the system"
        }
        
        // Use system archetypes
        platform = softwareSystem "Business Platform" "azure-service-system" {
            description "Cloud-based business management platform"
        }
        
        // Define relationships
        customer -> platform "Uses for business management"
    }
    
    views {
        systemLandscape "Overview" {
            include *
            autoLayout
        }
    }
}
```

### 2. Container Modeling

Use container archetypes within software systems:

```dsl
businessSystem = softwareSystem "Business System" "azure-service-system" {
    webApp = container "Web Application" "microservice-node-container" {
        description "React-based user interface"
    }
    
    api = container "Business API" "microservice-java-container" {
        description "Spring Boot REST API"
    }
    
    database = container "Database" "cosmosdb-container" {
        description "Document database for business data"
    }
    
    webApp -> api "Makes API calls to"
    api -> database "Stores and retrieves data from"
}
```

### 3. Component Modeling

Define components within containers using component archetypes:

```dsl
api = container "Business API" "microservice-java-container" {
    controller = component "Business Controller" "microservice-restapi-component" {
        description "Handles HTTP requests for business operations"
    }
    
    eventHandler = component "Event Handler" "event-component" {
        description "Processes business events"
    }
    
    controller -> eventHandler "Publishes events to"
}
```

## Archetype Categories

### Person Archetypes (`persons/`)

Predefined person types for common user roles:

- **consultor-person**: Business consultants and advisors
- **gerente-loja-person**: Store managers and local administrators
- **gerente-regional-person**: Regional managers overseeing multiple locations
- **gerente-territorial-person**: Territorial managers with broader scope
- **diretor-person**: Directors and executive-level users
- **cliente-person**: End customers and clients
- **desenvolvedor-person**: Software developers and technical users
- **arquiteto-person**: System architects and technical leads
- **agente-externo-person**: External agents and third-party integrators

### Software System Archetypes (`systems/`)

Common system patterns for different architectural contexts:

- **azure-service-system**: Azure cloud service systems
- **channel-system**: Communication and messaging channel systems
- **cluster-namespace-system**: Kubernetes namespace-based systems
- **external-resource-system**: External third-party systems
- **integration-system**: Integration platforms and middleware
- **on-premise-system**: On-premises legacy systems

### Container Archetypes (`containers/`)

Standardized container patterns for different technologies:

**Data Storage Containers:**
- **redis-container**: Redis cache and session storage
- **cosmosdb-postgres-container**: CosmosDB PostgreSQL containers
- **cosmosdb-container**: CosmosDB NoSQL document containers
- **mongodb-atlas-container**: MongoDB Atlas cloud database containers

**Messaging Containers:**
- **eventhub-container**: Azure Event Hub streaming containers
- **servicebus-container**: Azure Service Bus messaging containers

**Service Containers:**
- **microservice-java-container**: Java-based microservice containers
- **microservice-node-container**: Node.js-based microservice containers
- **apigateway-container**: API Gateway and routing containers
- **keyvault-container**: Azure Key Vault security containers

### Component Archetypes (`components/`)

Fine-grained component patterns for internal system structure:

**Data Components:**
- **redis-instance-component**: Redis cache instances
- **cosmosdb-postgres-table-component**: PostgreSQL table components
- **cosmosdb-collection-component**: CosmosDB document collections
- **mongodb-atlas-collection-component**: MongoDB Atlas collections

**Messaging Components:**
- **eventhub-topic-component**: Event Hub topic components
- **servicebus-queue-component**: Service Bus queue components
- **message-component**: Generic message entities
- **event-component**: Event-driven components

**Service Components:**
- **microservice-restapi-component**: REST API service components

### Custom Archetypes (`custom-archetypes/`)

Domain-specific patterns that extend base functionality:

- **domain-system-archetype**: Domain-driven system patterns
- **function-container-archetype**: Serverless function containers
- **event-component-archetype**: Event-driven component patterns
- **message-component-archetype**: Message-based component patterns
- **sub-function-component-archetype**: Sub-function component patterns

## Styling and Themes

The framework includes consistent styling through:

### Element Styles (`styles/element-styles.dsl`)
- Standardized colors and shapes for different element types
- Consistent visual hierarchy across all diagrams
- Technology-specific styling for containers and components

### Relationship Styles (`styles/relationship-styles.dsl`)
- Consistent line styles and colors for different relationship types
- Visual distinction between synchronous and asynchronous communications
- Protocol-specific styling (HTTP, messaging, database connections)

### Themes (`themes/`)
- **c4-framework-default.json**: Standard corporate theme
- **c4-framework-dark.json**: Dark mode theme for presentations
- **c4-framework-colorful.json**: High-contrast colorful theme

## Terminology Management

The framework uses centralized terminology definitions (`terminology/definitions.dsl` and `terminology/workspace.dsl`) to ensure consistent language across all models:

- **Person** → "User" or "Actor"
- **Software System** → "System" or "Platform"
- **Container** → "Service" or "Component"
- **Component** → "Module" or "Function"
- **Deployment Node** → "Infrastructure" or "Environment"

## Best Practices

### 1. Archetype Selection
- Choose the most specific archetype that matches your use case
- Extend archetypes with additional properties rather than modifying base definitions
- Use consistent naming conventions across your models

### 2. Hierarchical Identifiers
- The framework enforces hierarchical identifiers for consistency
- Use descriptive names that reflect the business domain
- Maintain clear parent-child relationships in your model structure

### 3. Documentation
- Include meaningful descriptions for all elements
- Use properties to capture important metadata
- Reference requirements and design decisions in element descriptions

### 4. Styling Consistency
- Use the provided themes and styles for visual consistency
- Extend styles only when necessary for domain-specific requirements
- Maintain color and shape conventions across different diagram types

## Advanced Usage

### Custom Archetype Creation

To create domain-specific archetypes, extend the framework workspace:

```dsl
workspace extends "c4framework/workspace.dsl" {
    model {
        archetypes {
            "ECommerceSystem" {
                description "E-commerce platform system"
                tags "ECommerce,Retail,Platform"
                properties {
                    "domain" "Retail"
                    "business.model" "B2C"
                    "payment.integration" "Required"
                }
            }
        }
        
        // Use the custom archetype
        onlineStore = softwareSystem "Online Store" "ECommerceSystem" {
            description "Customer-facing e-commerce platform"
        }
    }
}
```

### Infrastructure Modeling

Model deployment environments using infrastructure archetypes:

```dsl
deploymentEnvironment "Production" {
    deploymentNode "Azure Kubernetes Service" "cluster-namespace-system" {
        deploymentNode "Web Tier" {
            containerInstance webApp
        }
        
        deploymentNode "API Tier" {
            containerInstance businessAPI
        }
    }
}
```

## Support and Contribution

### Architecture Decision Records (ADRs)

The framework's design decisions are documented in the `docs/adr/` directory:

- **ADR-001**: Archetype-based framework design approach
- **ADR-002**: Hierarchical identifier strategy
- **ADR-003**: Modular file organization approach
- **ADR-004**: Styling and theming conventions

### Framework Evolution

The C4 Framework follows these principles for evolution:

1. **Backward Compatibility**: New versions maintain compatibility with existing models
2. **Incremental Enhancement**: New archetypes are added based on common usage patterns
3. **Community Feedback**: Framework improvements are driven by user needs and feedback
4. **Documentation First**: All changes are documented with clear migration guides

For questions, suggestions, or contributions, please refer to the project's contribution guidelines and architecture decision records.