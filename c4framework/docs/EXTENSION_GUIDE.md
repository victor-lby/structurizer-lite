# C4 Framework Extension Guide

## Overview
This enterprise C4 framework provides a foundation for cross-team architectural modeling. Teams can extend the framework while maintaining consistency and reusability.

## Extension Patterns

### 1. Custom Archetypes
Create team-specific archetypes by extending base patterns:

```dsl
// Example: Team-specific system archetype
MyTeamSystem = softwareSystem "My Team System" {
    description "Custom system for my team's domain"
    tags "MyTeam,Custom,Domain"
    
    // Inherit from base archetype
    !include "../systems/domain-system-archetype.dsl"
    
    // Add team-specific properties
    properties {
        "team.name" "My Team"
        "domain.area" "Specific Domain"
        "tech.stack" "Team Technology Stack"
    }
}
```

### 2. Team Workspaces
Structure team workspaces to extend the base framework:

```
team-workspace/
├── workspace.dsl              # Team workspace extending base
├── team-archetypes/          # Team-specific archetypes
├── team-systems/             # Team system definitions
├── team-views/               # Team-specific views
└── extensions/
    ├── custom-styles.dsl     # Team styling overrides
    └── team-terminology.dsl  # Team-specific terms
```

### 3. Workspace Extension Pattern
```dsl
workspace extends "../c4framework/workspace.dsl" {
    model {
        // Team-specific elements
        myTeamSystem = MyTeamSystem "Team System Name" {
            // Team implementation
        }
        
        // Team relationships
        consultant -> myTeamSystem "Uses"
    }
    
    views {
        // Team-specific views
        systemContext myTeamSystem "team-context" {
            include *
            autoLayout tb
        }
        
        // Override styling if needed
        styles {
            !include "./extensions/custom-styles.dsl"
        }
    }
}
```

## Best Practices

### Naming Conventions
- **Archetypes**: PascalCase (e.g., `MyTeamSystem`)
- **Instances**: camelCase (e.g., `myTeamSystem`)
- **Files**: kebab-case (e.g., `my-team-system.dsl`)
- **Tags**: Team prefix (e.g., `MyTeam,Domain,API`)

### Property Standards
Use consistent property naming:
```dsl
properties {
    "team.name" "Team Name"
    "team.contact" "team@company.com"
    "system.owner" "Team Name"
    "tech.stack" "Technology Stack"
    "deployment.env" "Environment"
    "compliance.level" "Level"
}
```

### Documentation Integration
- Document team-specific archetypes
- Maintain team glossaries
- Link to team ADRs and documentation

## Framework Governance

### Version Control
- Base framework in main branch
- Team extensions in feature branches
- Merge requests for framework updates

### Quality Gates
- Archetype validation
- Naming convention compliance
- Documentation completeness
- Style consistency checks

### Support Channels
- Framework documentation wiki
- Team Slack/Teams channels
- Architecture review sessions
- Framework office hours
