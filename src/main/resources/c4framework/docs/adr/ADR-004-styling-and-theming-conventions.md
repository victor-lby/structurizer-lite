# ADR-004: Styling and Theming Conventions

## Status
Accepted

## Context
The C4 Framework needs consistent visual styling across all generated diagrams to ensure professional appearance, clear communication, and brand consistency. Users should be able to create diagrams that follow established visual conventions while having the flexibility to customize appearance for specific contexts or organizational requirements.

Several approaches to styling and theming were considered:
1. **No styling framework**: Let users define their own styles
2. **Embedded styles**: Include all styling within archetype definitions
3. **Centralized styling system**: Separate style definitions with theme support
4. **Mixed approach**: Combination of archetype-specific and centralized styling

The framework must balance consistency with flexibility while supporting:
- Professional diagram appearance
- Clear visual hierarchy and element distinction
- Accessibility and readability requirements
- Organizational branding and customization needs
- Multiple output formats and contexts

## Decision
The C4 Framework will implement a centralized styling and theming system with separate style definitions, multiple theme options, and consistent visual conventions across all archetype categories.

## Rationale

### Centralized Styling Benefits

**Consistency Across Framework**
- All diagrams follow the same visual conventions
- Consistent color schemes and element styling
- Uniform relationship and connector appearance
- Professional, cohesive visual identity

**Maintainability**
- Single source of truth for visual styling
- Easy to update styles across entire framework
- Clear separation between content and presentation
- Simplified testing and validation of visual changes

**Flexibility and Customization**
- Multiple theme options for different contexts
- Easy to create organization-specific themes
- Support for accessibility requirements
- Customizable without modifying core archetypes

**Professional Quality**
- Carefully designed color palettes and typography
- Consistent visual hierarchy and information design
- Optimized for different output formats and sizes
- Accessibility-compliant color choices and contrast ratios

### Styling Architecture

**Element Styles (`styles/element-styles.dsl`)**
```dsl
styles {
    element "Person" {
        shape Person
        background "#08427b"
        color "#ffffff"
        fontSize 14
    }
    
    element "SoftwareSystem" {
        shape RoundedBox
        background "#1168bd"
        color "#ffffff"
        fontSize 16
    }
    
    element "Container" {
        shape RoundedBox
        background "#438dd5"
        color "#ffffff"
        fontSize 14
    }
    
    element "Component" {
        shape RoundedBox
        background "#85bbf0"
        color "#000000"
        fontSize 12
    }
    
    // Technology-specific styling
    element "Database" {
        shape Cylinder
        background "#1565c0"
        color "#ffffff"
    }
    
    element "WebBrowser" {
        shape WebBrowser
        background "#438dd5"
        color "#ffffff"
    }
    
    element "Mobile" {
        shape MobileDevicePortrait
        background "#438dd5"
        color "#ffffff"
    }
}
```

**Relationship Styles (`styles/relationship-styles.dsl`)**
```dsl
styles {
    relationship "Relationship" {
        color "#707070"
        thickness 2
        routing "Orthogonal"
        fontSize 10
    }
    
    relationship "Synchronous" {
        color "#2e7d32"
        thickness 2
        style "solid"
    }
    
    relationship "Asynchronous" {
        color "#ff9800"
        thickness 2
        style "dashed"
    }
    
    relationship "Database" {
        color "#1565c0"
        thickness 3
        style "solid"
    }
}
```

**Theme System**
- **Default Theme**: Professional corporate styling
- **Dark Theme**: Dark mode for presentations and low-light environments
- **Colorful Theme**: High-contrast theme for accessibility and emphasis

### Visual Design Principles

**Color Strategy**
- Blue-based primary palette for professional appearance
- Consistent color families for related element types
- High contrast ratios for accessibility compliance
- Semantic color usage (green for success, red for errors, etc.)

**Typography and Sizing**
- Consistent font sizes across element hierarchy
- Readable text at different zoom levels and output formats
- Clear visual hierarchy through size differentiation
- Optimized for both screen and print output

**Shape and Layout**
- Meaningful shapes that reinforce element types
- Consistent spacing and alignment principles
- Clear visual grouping and hierarchy
- Optimized for automatic layout algorithms

**Accessibility Considerations**
- WCAG 2.1 AA compliant color contrast ratios
- Colorblind-friendly color choices
- Clear visual distinctions beyond color alone
- Readable text sizes and font choices

## Implementation Details

### Theme Files

**Default Theme (`themes/c4-framework-default.json`)**
```json
{
    "name": "C4 Framework Default",
    "description": "Professional corporate theme for C4 Framework",
    "elements": [
        {
            "tag": "Person",
            "background": "#08427b",
            "color": "#ffffff",
            "shape": "Person"
        },
        {
            "tag": "SoftwareSystem",
            "background": "#1168bd",
            "color": "#ffffff",
            "shape": "RoundedBox"
        }
    ],
    "relationships": [
        {
            "tag": "Relationship",
            "color": "#707070",
            "thickness": 2
        }
    ]
}
```

**Dark Theme (`themes/c4-framework-dark.json`)**
- Dark background optimized for presentations
- High contrast elements for visibility
- Reduced eye strain in low-light environments
- Maintains visual hierarchy and accessibility

**Colorful Theme (`themes/c4-framework-colorful.json`)**
- High-contrast color palette for emphasis
- Distinct colors for different element types
- Accessibility-optimized color choices
- Enhanced visual distinction for complex diagrams

### Integration with Archetypes

**Tag-Based Styling**
- Archetypes define semantic tags for styling
- Styles applied based on tag matching
- Supports multiple tags per element for flexible styling
- Clear separation between content and presentation

**Property-Driven Customization**
- Archetype properties can influence styling choices
- Support for conditional styling based on element metadata
- Flexible customization without modifying core styles
- Maintains consistency while allowing specialization

### Usage Patterns

**Framework Integration**
```dsl
workspace extends "c4framework/workspace.dsl" {
    model {
        // Archetypes automatically include appropriate tags for styling
        customer = person "Customer" "consultor-person" {
            // Inherits Person styling through archetype tags
        }
        
        system = softwareSystem "Business System" "azure-service-system" {
            // Inherits SoftwareSystem and Azure-specific styling
        }
    }
    
    views {
        systemLandscape "Overview" {
            include *
            autoLayout
        }
        
        // Styles and themes automatically applied
        styles {
            !include c4framework/styles/element-styles.dsl
            !include c4framework/styles/relationship-styles.dsl
        }
        
        themes "default"
        !include c4framework/themes/c4-framework-default.json
    }
}
```

**Custom Theme Creation**
```json
{
    "name": "Organization Custom Theme",
    "description": "Custom theme for Organization branding",
    "extends": "c4framework/themes/c4-framework-default.json",
    "elements": [
        {
            "tag": "SoftwareSystem",
            "background": "#company-primary-color",
            "color": "#company-text-color"
        }
    ]
}
```

## Consequences

### Positive Consequences

**Visual Consistency**
- All framework-generated diagrams have consistent appearance
- Professional quality output suitable for presentations and documentation
- Clear visual hierarchy and information design
- Reduced cognitive load for diagram readers

**Maintainability**
- Easy to update visual styling across entire framework
- Clear separation between content and presentation concerns
- Simplified testing and validation of visual changes
- Version control friendly styling definitions

**Flexibility**
- Multiple theme options for different contexts and requirements
- Easy customization for organizational branding
- Support for accessibility requirements and preferences
- Extensible system for future styling needs

**Professional Quality**
- Carefully designed visual elements and color schemes
- Optimized for different output formats and contexts
- Accessibility-compliant design choices
- Consistent with industry best practices for technical diagrams

### Negative Consequences

**Complexity**
- Additional files and configuration for styling system
- Need to understand theme and styling concepts
- Potential for styling conflicts or inconsistencies
- Learning curve for customization and theme creation

**Maintenance Overhead**
- Need to maintain multiple theme files and style definitions
- Testing required across different themes and output formats
- Potential for styling regressions with framework updates
- Documentation requirements for styling customization

**Flexibility Limitations**
- Centralized styling may not meet all specific requirements
- Theme system constraints may limit some customization options
- Potential conflicts between framework styles and user preferences
- Balance needed between consistency and flexibility

### Mitigation Strategies

**Documentation and Examples**
- Comprehensive styling and theming documentation
- Examples of custom theme creation and modification
- Best practices for styling customization
- Migration guides for styling updates

**Validation and Testing**
- Automated testing of styling across different themes
- Visual regression testing for styling changes
- Accessibility compliance validation
- Cross-platform and output format testing

**Community and Feedback**
- Regular collection of user feedback on styling and themes
- Community contribution process for new themes
- Regular review and update of styling conventions
- Support for user-contributed themes and styles

## Related Decisions
- ADR-001: Archetype-Based Framework Design
- ADR-002: Hierarchical Identifier Strategy
- ADR-003: Modular File Organization Approach

## References
- [Structurizr DSL Styling Documentation](https://docs.structurizr.com/dsl/styling)
- [Structurizr Themes Documentation](https://docs.structurizr.com/ui/themes)
- [WCAG 2.1 Accessibility Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [Color Universal Design Organization](https://jfly.uni-koeln.de/color/)
- [C4 Model Visual Conventions](https://c4model.com/)