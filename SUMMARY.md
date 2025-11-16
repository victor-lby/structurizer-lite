# Structurizr Lite - Code Analysis Summary

## Repository Overview

**Repository:** victor-lby/structurizer-lite  
**Type:** Java Spring Boot Web Application  
**Purpose:** Free and open-source version of Structurizr for viewing/editing C4 architecture diagrams via DSL or JSON workspaces  
**Build System:** Gradle 7.6.4  
**Java Version:** 17  
**Spring Boot Version:** 3.5.7  

## Project Structure

### Core Components

The repository follows a standard Spring Boot application structure with the following key components:

#### 1. Main Application Layer
- **Location:** `src/main/java/com/structurizr/lite/`
- **Entry Point:** `StructurizrLite.java` - Spring Boot application with embedded Tomcat server
- **Configuration:** `Configuration.java` - Manages workspace paths, properties, and runtime settings

#### 2. Component Architecture

The application is organized into three main component packages:

##### Workspace Component (`component/workspace/`)
Responsible for managing workspace data on the file system:
- `WorkspaceComponent.java` - Interface defining workspace operations
- `FileSystemWorkspaceComponentImpl.java` - Implementation that handles DSL and JSON workspace files
- `WorkspaceDirectory.java` - Directory management utilities
- Key functionality:
  - Loads workspaces from `.dsl` or `.json` files
  - Parses DSL files using `StructurizrDslParser`
  - Supports auto-save and auto-refresh mechanisms
  - Manages workspace images and metadata

##### Search Component (`component/search/`)
Provides full-text search capabilities using Apache Lucene:
- `SearchComponent.java` - Search interface
- `ApacheLuceneSearchComponentImpl.java` - Lucene-based search implementation
- Indexes workspace content for fast retrieval
- Supports searching across documentation, decisions, and diagrams

##### Web Layer (`web/`)
Contains 28 Spring MVC controllers handling HTTP requests:
- `ModelController.java` - Workspace model operations
- `DocumentationController.java` - Documentation management
- `DecisionsController.java` - Architecture Decision Records (ADR)
- `GraphController.java` - Diagram rendering
- `SearchController.java` - Search functionality
- `EmbedController.java` - Embedded diagram views
- Additional controllers for API endpoints and UI rendering

#### 3. Utility Layer (`util/`)
Support classes for common operations:
- `DateUtils.java` - Date formatting and manipulation
- `JsonUtils.java` - JSON serialization/deserialization
- `HtmlUtils.java` - HTML sanitization and rendering
- `Image.java` - Image file handling
- `Version.java` - Build version information
- `RandomGuidGenerator.java` - GUID generation for API keys

#### 4. View Layer
- **Location:** `src/main/webapp/WEB-INF/`
- **Technology:** JSP (JavaServer Pages) with JSTL
- **Key Views:**
  - `home.jsp` - Main workspace dashboard
  - `search-results.jsp` - Search results display
- **Fragments:** Reusable UI components for auto-save, auto-refresh, and workspace management

#### 5. Static Resources
- **Location:** `src/main/resources/static/`
- **Contents:** JavaScript, CSS, and client-side assets for the web UI

### Dependencies

Key external libraries (from `build.gradle`):
- **Structurizr Libraries:**
  - `structurizr-dsl` (v5.0.1) - DSL parsing
  - `structurizr-autolayout` (v5.0.1) - Automatic diagram layout
  - `structurizr-inspection` (v5.0.1) - Workspace validation
- **Scripting Support:**
  - Groovy JSR223 (v3.0.25)
  - Kotlin Scripting (v1.9.25)
  - JRuby (v9.4.12.1)
- **Search:** Apache Lucene (v9.12.3)
- **Web:** Spring Boot Starter Web, Tomcat Embed Jasper

## How Structurizr Lite Works

### Workspace Loading Process

1. **Initialization:** Application starts and reads configuration from:
   - Environment variable `STRUCTURIZR_WORKSPACE_PATH` (workspace directory)
   - Environment variable `STRUCTURIZR_WORKSPACE_FILENAME` (default: "workspace")
   - Optional `structurizr.properties` file in workspace directory

2. **File Discovery:** The `FileSystemWorkspaceComponentImpl` looks for workspace files:
   - Prefers `.dsl` files for authoring
   - Falls back to `.json` files if DSL not found
   - Default location: `/usr/local/structurizr/` (configurable via command-line argument)

3. **DSL Parsing:** When a `.dsl` file is found:
   - `StructurizrDslParser` parses the DSL syntax
   - Supports `!include` directives for modular DSL files
   - Validates workspace scope
   - Runs default inspections
   - Creates default views if model exists but views don't
   - Copies layout information from existing JSON file (if present)
   - Saves parsed workspace as JSON for faster subsequent loads

4. **Workspace Rendering:** The web UI displays:
   - Architecture diagrams (System Context, Container, Component, Deployment)
   - Documentation pages
   - Architecture Decision Records (ADRs)
   - Search functionality across all content

### Configuration Options

The application supports configuration via `structurizr.properties`:
- `structurizr.workspaces` - Single workspace ("1") or multiple workspaces mode
- `structurizr.editable` - Enable/disable editing (default: true)
- `structurizr.url` - Base URL for the application
- `structurizr.autoSaveInterval` - Auto-save interval in milliseconds (default: 5000)
- `structurizr.autoRefreshInterval` - Auto-refresh interval in milliseconds (default: 0)
- Remote workspace synchronization settings (API URL, key, secret, workspace ID)

## C4 Framework Analysis

### Structure

The `c4framework/` directory contains a comprehensive C4 modeling framework with reusable archetypes:

#### Framework Organization

```
c4framework/
├── workspace.dsl                    # Main workspace definition with archetype includes
├── persons/                         # Person archetypes (9 files)
│   ├── consultor-person.dsl
│   ├── agente-externo-person.dsl
│   ├── arquiteto-person.dsl
│   ├── cliente-person.dsl
│   ├── desenvolvedor-person.dsl
│   ├── diretor-person.dsl
│   ├── gerente-loja-person.dsl
│   ├── gerente-regional-person.dsl
│   └── gerente-territorial-person.dsl
├── systems/                         # System archetypes (5 files)
│   ├── azure-service-system.dsl
│   ├── bounded-context.dsl
│   ├── channel-system.dsl
│   ├── external-resource-system.dsl
│   └── on-premise-system.dsl
├── containers/                      # Container archetypes (10 files)
│   ├── apigateway-container.dsl
│   ├── cosmosdb-container.dsl
│   ├── cosmosdb-postgres-container.dsl
│   ├── eventhub-container.dsl
│   ├── keyvault-container.dsl
│   ├── microservice-java-container.dsl
│   ├── microservice-node-container.dsl
│   ├── mongodb-atlas-container.dsl
│   ├── redis-container.dsl
│   └── servicebus-container.dsl
├── components/                      # Component archetypes (10 files)
│   ├── cosmosdb-collection-component.dsl
│   ├── cosmosdb-postgres-table-component.dsl
│   ├── event-component.dsl
│   ├── eventhub-topic-component.dsl
│   ├── message-component.dsl
│   ├── microservice-restapi-component.dsl
│   ├── microservice-soap-component.dsl
│   ├── mongodb-atlas-collection-component.dsl
│   ├── redis-instance-component.dsl
│   └── servicebus-queue-component.dsl
├── styles/                          # Visual styling (2 files)
│   ├── element-styles.dsl          # 19 element styles with color palette
│   └── relationship-styles.dsl     # Relationship visual definitions
├── themes/                          # Custom themes (3 JSON files)
│   ├── c4-framework-default.json
│   ├── c4-framework-colorful.json
│   └── c4-framework-dark.json
├── terminology/                     # Custom terminology definitions
│   └── definitions.dsl
├── docs/                           # Documentation
│   └── adr/                        # Architecture Decision Records
└── .structurizr/                   # Structurizr workspace metadata
    └── 1/                          # Workspace ID 1
        └── images/                 # Embedded images
```

#### Framework Statistics
- **Total DSL Files:** 39
- **Person Archetypes:** 9 (role-based personas)
- **System Archetypes:** 5 (deployment and technology patterns)
- **Container Archetypes:** 10 (core infrastructure patterns)
- **Component Archetypes:** 10 (fine-grained component patterns)
- **Style Files:** 2 (element and relationship styles)
- **Theme Files:** 3 (visual theme variants)

### Archetype Pattern

The c4framework uses a sophisticated archetype pattern for reusable C4 elements:

#### Person Archetypes
Define standard properties for user roles with consistent tagging:
- All persons use "User" tag for C4 compliance
- Include properties: user.type, access.level, role.category, interaction.mode, expertise, role.name
- Examples: Consultant, External Agent, Architect, Client, Developer, Director, Store Manager, Regional Manager, Territorial Manager

#### System Archetypes
Represent deployment and technology patterns:
- Bounded Context (DDD pattern)
- Channel System (communication channels)
- External Resource System (third-party systems)
- On-Premise System (on-premises deployments)
- Azure Service System (cloud services)

#### Container Archetypes
Core infrastructure patterns with technology-specific properties:
- Microservices (Java Spring Boot, Node.js)
- Databases (CosmosDB, CosmosDB PostgreSQL, MongoDB Atlas, Redis)
- Message Brokers (Azure Event Hub, Azure Service Bus)
- Infrastructure (API Gateway, Azure Key Vault)
- Include properties: container.type, runtime, framework, architecture.style, communication, packaging, monitoring, use.case
- Support perspectives: Technical, Operational, Performance

#### Component Archetypes
Fine-grained component patterns:
- REST API components
- SOAP API components
- Event components
- Message queue components
- Database collection/table components
- Cache instance components

### Styling System

The framework includes a comprehensive styling system:

#### Color Palette (8 colors)
Follows strict color guidelines with semantic meaning:
- **Pink (#ea3e84):** New elements (created in current iteration)
- **Purple (#7030a0):** Altered elements (modified in current iteration)
- **Gray (#9e9e9e):** Same elements (unchanged, for context)
- Stroke colors derived from base colors (darker variants)
- Text color: Always white (#ffffff) for contrast

#### Element Styles (19 styles)
- User (person shape)
- Applications: AppNew, AppAlt, AppSame (rounded boxes)
- Microservices: SvcNew, SvcAlt, SvcSame (boxes)
- Bounded Contexts: BCNew, BCAlt, BCSame (rounded boxes)
- API Gateways: GatewayNew, GatewayAlt, GatewaySame (hexagons)
- Event Brokers: EbNew, EbAlt, EbSame (pipes)
- Databases: DbNew, DbAlt, DbSame (cylinders)
- Components: ComponentNew, ComponentAlt, ComponentSame (component shape)
- External Systems: ExtNew, ExtAlt, ExtSame (boxes with thinner stroke)

#### Shape Semantics
- **Person:** Human actors
- **Box:** Services and external systems
- **Rounded Box:** Applications and bounded contexts
- **Hexagon:** API gateways and routing components
- **Pipe:** Event brokers and message queues
- **Cylinder:** Databases and persistent storage
- **Component:** Fine-grained components

### Framework Usage Pattern

The main `workspace.dsl` demonstrates the intended usage:

```dsl
workspace "C4 Framework" "..." {
    !identifiers hierarchical
    
    model {
        archetypes {
            !include "./persons/consultor-person.dsl"
            !include "./systems/bounded-context.dsl"
            !include "./containers/microservice-java-container.dsl"
            !include "./components/microservice-restapi-component.dsl"
            // ... more includes
        }
    }
    
    views {
        styles {
            !include "./styles/element-styles.dsl"
            !include "./styles/relationship-styles.dsl"
            theme default
        }
        !include "./terminology/definitions.dsl"
        themes "./themes/c4-framework-colorful.json" ...
        branding { ... }
    }
}
```

## Current Build Status

**Note:** The repository has a build issue unrelated to the c4framework:
- **Error:** Missing `DslTemplate` class in `structurizr-util` package
- **Location:** `FileSystemWorkspaceComponentImpl.java:12` and line 79
- **Impact:** Build fails during compilation
- **Cause:** Likely a version mismatch between Structurizr Lite and the structurizr-dsl library (v5.0.1)
- **Scope:** This is a pre-existing issue in the repository, not introduced by the c4framework addition

The application architecture is sound, and the issue appears to be a dependency version compatibility problem that would need to be resolved separately.

## Key Observations

1. **Modular Architecture:** Structurizr Lite uses a clean separation of concerns with distinct components for workspace management, search, and web presentation.

2. **DSL-First Approach:** The application prioritizes DSL files over JSON, making it ideal for version-controlled architecture documentation.

3. **Include Directive Support:** The DSL parser supports `!include` directives, which is the foundation for embedding reusable frameworks like c4framework.

4. **File System Based:** Workspaces are stored as files on the file system, making them easy to manage with standard tools (git, editors, etc.).

5. **Auto-Save/Refresh:** Built-in mechanisms for automatic saving and refreshing of workspace changes.

6. **Comprehensive Framework:** The c4framework provides 39 DSL files covering the full spectrum of C4 modeling needs with consistent styling and patterns.

7. **Enterprise-Ready:** The framework includes Azure-specific archetypes (CosmosDB, Event Hub, Service Bus, Key Vault) indicating enterprise cloud architecture focus.

8. **Semantic Versioning:** The framework uses color-coded status tags (New/Alt/Same) to indicate element lifecycle in architecture evolution.

## Technical Stack Summary

- **Backend:** Java 17, Spring Boot 3.5.7, Gradle 7.6.4
- **Web Server:** Embedded Tomcat with JSP/JSTL
- **DSL Parsing:** Structurizr DSL Parser v5.0.1
- **Search:** Apache Lucene 9.12.3
- **Scripting:** Groovy, Kotlin, JRuby support
- **Deployment:** Docker support via Dockerfile (Eclipse Temurin JRE 21)
- **Architecture:** MVC pattern with component-based organization
- **Storage:** File system based (DSL and JSON files)

## Repository Health

- **License:** MIT License
- **Documentation:** Basic README with link to official docs
- **Build System:** Gradle with test suites (unit and integration tests)
- **Containerization:** Dockerfile provided for easy deployment
- **Version Control:** Git with proper .gitignore
- **Submodules:** Uses git submodules (.gitmodules present)
