# ADR-001: Archetype-Based Framework Design

## Status
Accepted

## Context
We need to create a reusable C4 modeling framework that provides standardized templates for common architectural patterns. The framework should enable architects to quickly create consistent models without starting from scratch, while maintaining flexibility for customization and extension.

Several approaches were considered:
1. **Custom templating system**: Build a proprietary template engine
2. **Code generation approach**: Generate DSL files from templates
3. **Structurizr DSL archetypes**: Use native DSL archetype functionality
4. **Copy-paste templates**: Provide example files for manual copying

## Decision
We will use Structurizr DSL's native `archetypes` feature as the foundation for the C4 Framework.

## Rationale

### Advantages of Archetype-Based Approach

**Native DSL Integration**
- Leverages built-in Structurizr DSL functionality
- No additional tooling or build processes required
- Seamless integration with existing DSL workflows
- Full compatibility with Structurizr tooling ecosystem

**Type Safety and Validation**
- DSL parser validates archetype usage at parse time
- Compile-time checking of archetype references
- Automatic validation of required properties and relationships
- Clear error messages for incorrect usage

**Extensibility and Inheritance**
- Archetypes can be extended and specialized
- Support for archetype composition and layering
- Easy to add domain-specific extensions
- Maintains backward compatibility when extending

**Workspace Integration**
- Archetypes are defined within the workspace model
- Can be extended by other workspaces using `workspace extends`
- Supports modular organization through `!include` statements
- Enables centralized archetype libraries

### Technical Benefits

**Performance**
- No runtime template processing overhead
- Archetypes are resolved at parse time
- Efficient memory usage during model construction
- Fast diagram generation and rendering

**Maintainability**
- Single source of truth for archetype definitions
- Clear separation between framework and user models
- Version control friendly (plain text DSL files)
- Easy to track changes and evolution

**Flexibility**
- Users can override archetype properties as needed
- Support for partial archetype usage
- Can combine multiple archetypes in single elements
- Allows for gradual adoption and migration

### Framework Design Implications

**Modular Organization**
- Each archetype category gets its own directory structure
- Individual DSL files for each archetype enable focused maintenance
- Clear separation between persons, systems, containers, and components
- Support for custom domain-specific archetype extensions

**Hierarchical Structure**
- Framework enforces hierarchical identifiers for consistency
- Clear parent-child relationships in model organization
- Supports nested archetype definitions and specializations
- Enables scalable model organization

**Standardization**
- Consistent property naming across all archetypes
- Standardized tagging conventions for styling and filtering
- Unified approach to metadata and documentation
- Common patterns for relationships and interactions

## Consequences

### Positive Consequences

**For Framework Users**
- Reduced learning curve (uses standard DSL syntax)
- Immediate validation and error checking
- Full IDE support and syntax highlighting
- Easy integration with existing DSL workflows

**For Framework Maintainers**
- Leverages proven, stable DSL functionality
- No custom tooling to maintain or support
- Clear upgrade path as Structurizr DSL evolves
- Simplified testing and validation processes

**For Architecture Teams**
- Consistent models across projects and teams
- Reduced time to create new architectural models
- Improved model quality through standardized patterns
- Better collaboration through shared vocabulary

### Negative Consequences

**Limitations**
- Bound by Structurizr DSL archetype feature limitations
- Cannot implement complex conditional logic in archetypes
- Limited dynamic behavior compared to code generation approaches
- Dependent on Structurizr DSL evolution and support

**Learning Requirements**
- Users need to understand DSL archetype syntax
- Requires knowledge of workspace extension patterns
- Need to understand hierarchical identifier implications
- May require training for teams new to Structurizr DSL

### Mitigation Strategies

**Documentation and Training**
- Comprehensive documentation with examples
- Quick start guides for common usage patterns
- Best practices documentation for archetype usage
- Training materials for teams adopting the framework

**Framework Evolution**
- Regular review of Structurizr DSL feature updates
- Feedback collection from framework users
- Incremental enhancement based on usage patterns
- Backward compatibility maintenance strategies

**Tooling Support**
- IDE extensions and plugins where possible
- Validation tools for archetype usage
- Migration utilities for framework updates
- Integration with CI/CD pipelines

## Related Decisions
- ADR-002: Hierarchical Identifier Strategy
- ADR-003: Modular File Organization Approach
- ADR-004: Styling and Theming Conventions

## References
- [Structurizr DSL Language Reference](https://docs.structurizr.com/dsl/language)
- [Structurizr DSL Archetypes Documentation](https://docs.structurizr.com/dsl/archetypes)
- [C4 Model Documentation](https://c4model.com/)