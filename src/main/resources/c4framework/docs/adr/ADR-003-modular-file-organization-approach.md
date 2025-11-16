# ADR-003: Modular File Organization Approach

## Status
Accepted

## Context
The C4 Framework needs an organizational structure that supports maintainability, scalability, and ease of use. With multiple archetype categories (persons, systems, containers, components, custom archetypes) and supporting elements (styles, themes, terminology), we need a clear strategy for organizing DSL files that promotes:

- Easy navigation and discovery
- Maintainable codebase
- Clear separation of concerns
- Scalable growth as the framework evolves
- Efficient collaboration among framework maintainers

Several organizational approaches were considered:
1. **Monolithic single file**: All archetypes in one large DSL file
2. **Category-based directories**: Separate directories for each archetype type
3. **Flat file structure**: All archetype files in a single directory
4. **Hybrid approach**: Mix of directories and files based on complexity

## Decision
The C4 Framework will use a modular file organization approach with category-based directories and individual DSL files for each archetype, connected through a main workspace file using `!include` statements.

## Rationale

### Organizational Structure Benefits

**Clear Separation of Concerns**
- Each archetype category has its own directory
- Individual files for each archetype enable focused maintenance
- Supporting elements (styles, themes, terminology) are clearly separated
- Easy to locate and modify specific archetypes

**Scalability and Growth**
- New archetypes can be added without impacting existing ones
- Directory structure supports unlimited growth within categories
- Easy to add new archetype categories as framework evolves
- Supports parallel development by multiple maintainers

**Maintainability**
- Small, focused files are easier to understand and modify
- Clear dependencies through explicit `!include` statements
- Version control friendly with granular change tracking
- Reduced merge conflicts when multiple people work on framework

**Discoverability**
- Intuitive directory structure matches C4 model hierarchy
- Consistent naming conventions across all files
- Easy to browse and understand framework contents
- Self-documenting organization through directory names

### Technical Implementation

**Main Workspace Structure**
```dsl
workspace "C4 Framework" {
    !identifiers hierarchical always
    
    model {
        archetypes {
            // Person archetypes
            !include persons/consultor-person.dsl
            !include persons/gerente-loja-person.dsl
            !include persons/desenvolvedor-person.dsl
            // ... other person archetypes
            
            // System archetypes
            !include systems/azure-service-system.dsl
            !include systems/cluster-namespace-system.dsl
            // ... other system archetypes
            
            // Container archetypes
            !include containers/microservice-java-container.dsl
            !include containers/cosmosdb-container.dsl
            // ... other container archetypes
            
            // Component archetypes
            !include components/microservice-restapi-component.dsl
            !include components/event-component.dsl
            // ... other component archetypes
            
            // Custom archetypes
            !include custom-archetypes/domain-system-archetype.dsl
            !include custom-archetypes/function-container-archetype.dsl
            // ... other custom archetypes
        }
    }
    
    views {
        styles {
            !include styles/element-styles.dsl
            !include styles/relationship-styles.dsl
        }
        
        themes "default"
        !include themes/c4-framework-default.json
    }
    
    configuration {
        !include terminology/definitions.dsl
        !include terminology/workspace.dsl
    }
}
```

**Directory Structure**
```
c4framework/
├── workspace.dsl                    # Main framework workspace
├── persons/                         # Person archetype definitions
│   ├── consultor-person.dsl
│   ├── gerente-loja-person.dsl
│   ├── desenvolvedor-person.dsl
│   └── ...
├── systems/                         # Software system archetypes
│   ├── azure-service-system.dsl
│   ├── cluster-namespace-system.dsl
│   └── ...
├── containers/                      # Container archetypes
│   ├── microservice-java-container.dsl
│   ├── cosmosdb-container.dsl
│   └── ...
├── components/                      # Component archetypes
│   ├── microservice-restapi-component.dsl
│   ├── event-component.dsl
│   └── ...
├── custom-archetypes/              # Domain-specific archetypes
│   ├── domain-system-archetype.dsl
│   ├── function-container-archetype.dsl
│   └── ...
├── styles/                         # Styling definitions
│   ├── element-styles.dsl
│   └── relationship-styles.dsl
├── themes/                         # Theme files
│   ├── c4-framework-default.json
│   ├── c4-framework-dark.json
│   └── c4-framework-colorful.json
├── terminology/                    # Terminology definitions
│   ├── definitions.dsl
│   └── workspace.dsl
└── docs/                          # Documentation
    ├── README.md
    └── adr/
```

### File Naming Conventions

**Archetype Files**
- Pattern: `{archetype-name}-{type}.dsl`
- Examples: `consultor-person.dsl`, `azure-service-system.dsl`
- Consistent suffix indicates archetype category
- Kebab-case for multi-word names

**Supporting Files**
- Descriptive names reflecting their purpose
- Consistent patterns within each category
- Clear indication of file type and content

**Directory Names**
- Plural forms for archetype categories (`persons`, `systems`)
- Singular forms for supporting elements (`terminology`, `docs`)
- Lowercase with hyphens for multi-word names

## Implementation Benefits

### Development Workflow

**Focused Development**
- Developers can work on specific archetype categories independently
- Clear boundaries reduce cognitive load when making changes
- Easy to understand impact of modifications
- Supports incremental development and testing

**Version Control Integration**
- Granular change tracking at archetype level
- Meaningful commit messages for specific archetype changes
- Reduced merge conflicts with parallel development
- Clear history of framework evolution

**Testing and Validation**
- Individual archetype files can be tested independently
- Easy to isolate issues to specific archetypes
- Supports automated testing of archetype categories
- Clear validation boundaries for framework changes

### User Experience

**Framework Discovery**
- Users can easily browse available archetypes by category
- Clear understanding of framework capabilities
- Easy to find relevant archetypes for specific use cases
- Self-documenting structure through organization

**Selective Usage**
- Users can include only needed archetype categories
- Supports lightweight framework usage for simple cases
- Easy to extend with additional categories as needed
- Clear dependencies between different framework components

**Customization and Extension**
- Easy to add custom archetypes following established patterns
- Clear separation between framework and user customizations
- Supports domain-specific extensions without framework modification
- Maintains upgrade path for framework updates

## Consequences

### Positive Consequences

**Maintainability**
- Small, focused files are easier to understand and modify
- Clear separation of concerns reduces complexity
- Easy to locate and fix issues in specific archetypes
- Supports long-term framework evolution and growth

**Collaboration**
- Multiple developers can work on framework simultaneously
- Clear ownership boundaries for different archetype categories
- Reduced merge conflicts and integration issues
- Supports distributed development and contribution

**Scalability**
- Framework can grow without becoming unwieldy
- New archetype categories can be added easily
- Supports unlimited growth within existing categories
- Clear patterns for framework extension and evolution

**User Adoption**
- Easy to understand and navigate framework structure
- Clear discovery path for available archetypes
- Supports gradual adoption and learning
- Self-documenting organization reduces learning curve

### Negative Consequences

**File Proliferation**
- Many small files instead of few large ones
- Potential complexity in managing include statements
- Need for consistent naming and organization discipline
- May be overwhelming for users expecting single-file solutions

**Include Statement Management**
- Main workspace file requires maintenance as archetypes are added
- Risk of forgetting to include new archetype files
- Potential for include order dependencies
- Need for validation to ensure all archetypes are included

**Initial Complexity**
- More complex initial setup compared to single-file approach
- Need for understanding of include statement patterns
- Requires discipline in following organizational conventions
- May require tooling support for framework management

### Mitigation Strategies

**Automation and Tooling**
- Scripts to validate include statement completeness
- Automated generation of include statements for new archetypes
- Tooling to check naming convention compliance
- Integration with CI/CD for framework validation

**Documentation and Guidelines**
- Clear guidelines for adding new archetypes
- Examples of proper file organization and naming
- Best practices for maintaining include statements
- Training materials for framework contributors

**Framework Evolution**
- Regular review of organizational patterns
- Feedback collection from framework users and maintainers
- Incremental improvements to organizational structure
- Backward compatibility considerations for changes

## Related Decisions
- ADR-001: Archetype-Based Framework Design
- ADR-002: Hierarchical Identifier Strategy
- ADR-004: Styling and Theming Conventions

## References
- [Structurizr DSL Include Statements](https://docs.structurizr.com/dsl/includes)
- [Software Architecture Documentation Organization](https://docs.arc42.org/)
- [Modular Software Design Principles](https://en.wikipedia.org/wiki/Modular_programming)