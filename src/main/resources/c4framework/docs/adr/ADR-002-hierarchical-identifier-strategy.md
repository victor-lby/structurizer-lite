# ADR-002: Hierarchical Identifier Strategy

## Status
Accepted

## Context
The C4 Framework needs a consistent approach to element identification that supports scalable model organization, clear relationships, and maintainable references across large architectural models. The framework must work effectively for both simple single-system models and complex enterprise-wide architectural landscapes.

Structurizr DSL supports different identifier strategies:
1. **Flat identifiers**: Simple names without hierarchy
2. **Hierarchical identifiers**: Dot-notation paths reflecting containment
3. **Mixed approach**: Combination of flat and hierarchical as needed

## Decision
The C4 Framework will enforce hierarchical identifiers using `!identifiers hierarchical always` in the main workspace configuration.

## Rationale

### Benefits of Hierarchical Identifiers

**Clear Containment Relationships**
- Element identifiers reflect their position in the model hierarchy
- Easy to understand parent-child relationships from identifier alone
- Supports nested structures (system.container.component)
- Aligns with C4 model's natural hierarchical structure

**Namespace Management**
- Prevents naming conflicts across different contexts
- Allows same names in different containers/systems
- Supports large-scale models with many similar elements
- Enables clear scoping of element references

**Model Navigation and Understanding**
- Identifiers provide context about element location
- Easier to locate elements in large models
- Self-documenting element paths
- Supports tooling for model exploration and navigation

**Consistency Across Framework**
- All framework archetypes follow same identifier patterns
- Predictable naming conventions for all element types
- Consistent approach across different archetype categories
- Simplified training and adoption for framework users

### Technical Advantages

**Reference Resolution**
- Unambiguous element references in relationships
- Clear error messages when references are incorrect
- Supports refactoring and model reorganization
- Enables automated validation of model consistency

**Tooling Integration**
- Better support for IDE features (autocomplete, navigation)
- Improved diagram generation and layout algorithms
- Enhanced model analysis and reporting capabilities
- Simplified integration with external tools and systems

**Version Control and Collaboration**
- Meaningful identifiers in version control diffs
- Easier to track changes across model evolution
- Better support for merge conflict resolution
- Clear audit trails for model modifications

### Framework Design Implications

**Archetype Definitions**
- All framework archetypes assume hierarchical identifier context
- Archetype properties and relationships use hierarchical references
- Consistent identifier patterns across all archetype categories
- Support for nested archetype usage within hierarchies

**Model Organization**
- Encourages logical grouping of related elements
- Supports domain-driven model organization
- Enables clear separation of concerns
- Facilitates modular model development

**Relationship Modeling**
- Clear source and destination identification in relationships
- Support for cross-hierarchy relationships with full paths
- Consistent relationship naming and documentation
- Simplified relationship validation and analysis

## Implementation Details

### Workspace Configuration
```dsl
workspace "C4 Framework" {
    !identifiers hierarchical always
    
    model {
        // All elements automatically get hierarchical identifiers
        // system.container.component pattern enforced
    }
}
```

### Identifier Patterns

**Software Systems**
- Pattern: `{systemName}`
- Example: `ecommerceplatform`, `paymentsystem`

**Containers within Systems**
- Pattern: `{systemName}.{containerName}`
- Example: `ecommerceplatform.webapp`, `paymentsystem.api`

**Components within Containers**
- Pattern: `{systemName}.{containerName}.{componentName}`
- Example: `ecommerceplatform.webapp.productcatalog`

**Deployment Elements**
- Pattern: `{environment}.{node}.{instance}`
- Example: `production.kubernetes.webapp`

### Naming Conventions

**Consistency Rules**
- Use camelCase for multi-word identifiers
- Avoid special characters and spaces
- Use descriptive but concise names
- Maintain consistency within domain contexts

**Reserved Patterns**
- Avoid DSL keywords as identifier components
- Use consistent suffixes for similar element types
- Follow established patterns from framework archetypes
- Consider future extension and evolution needs

## Consequences

### Positive Consequences

**Model Clarity**
- Self-documenting element structure through identifiers
- Clear understanding of element relationships and containment
- Reduced ambiguity in large, complex models
- Better support for model documentation and communication

**Scalability**
- Supports growth from simple to complex models
- Handles enterprise-scale architectural landscapes
- Enables modular model development and maintenance
- Supports team collaboration on large models

**Tool Integration**
- Better IDE support for navigation and refactoring
- Enhanced diagram generation and layout
- Improved model analysis and reporting capabilities
- Simplified integration with external systems

**Framework Consistency**
- Uniform approach across all framework components
- Predictable patterns for framework users
- Simplified training and adoption processes
- Consistent behavior across different archetype types

### Negative Consequences

**Identifier Length**
- Longer identifiers for deeply nested elements
- Potential verbosity in relationship definitions
- May impact readability in some contexts
- Requires careful naming to balance clarity and brevity

**Migration Complexity**
- Existing flat identifier models require migration
- Potential breaking changes for existing users
- Need for migration tools and documentation
- Training requirements for teams familiar with flat identifiers

**Learning Curve**
- New users need to understand hierarchical patterns
- Requires understanding of containment relationships
- May be overwhelming for simple use cases
- Need for comprehensive documentation and examples

### Mitigation Strategies

**Documentation and Training**
- Clear examples of hierarchical identifier usage
- Best practices for naming conventions
- Migration guides for existing models
- Training materials for new framework users

**Tooling Support**
- IDE plugins for identifier navigation and validation
- Automated migration tools for existing models
- Validation utilities for identifier consistency
- Integration with model analysis and reporting tools

**Framework Evolution**
- Regular review of identifier patterns and conventions
- Feedback collection from framework users
- Incremental improvements based on usage patterns
- Backward compatibility considerations for updates

## Related Decisions
- ADR-001: Archetype-Based Framework Design
- ADR-003: Modular File Organization Approach
- ADR-004: Styling and Theming Conventions

## References
- [Structurizr DSL Identifiers Documentation](https://docs.structurizr.com/dsl/identifiers)
- [C4 Model Hierarchy Concepts](https://c4model.com/)
- [Software Architecture Documentation Best Practices](https://docs.arc42.org/)