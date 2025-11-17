# Visual Architecture Patterns Guide

This guide defines the visual patterns and styling conventions for each archetype in the C4 framework, ensuring consistent visual representation across all projects.

## 🎨 Design Philosophy

Each archetype has a unique visual identity that:
- **Immediately identifies** the architectural pattern
- **Communicates purpose** through color and shape
- **Maintains consistency** across all projects
- **Supports visual hierarchy** in complex diagrams

## 🏗️ System Archetype Patterns

### Domain System Pattern
- **Color**: Green (#2E7D32)
- **Shape**: Rounded Rectangle
- **Border**: Thick (3px) with darker green
- **Purpose**: Business domain and DDD systems
- **Visual Cue**: Green represents business/domain focus

```dsl
myDomainSystem = DomainSystem "Order Management" {
    // Automatically styled with green domain pattern
}
```

### Enterprise System Pattern
- **Color**: Corporate Blue (#1565C0)
- **Shape**: Rounded Rectangle
- **Border**: Extra thick (4px) for importance
- **Purpose**: Mission-critical enterprise systems
- **Visual Cue**: Blue represents corporate/enterprise grade

```dsl
myEnterpriseSystem = EnterpriseSystem "Core Banking" {
    // Automatically styled with blue enterprise pattern
}
```

### Cloud Native System Pattern
- **Color**: Modern Orange (#FF6F00)
- **Shape**: Hexagon (modern/tech)
- **Border**: Thick (3px)
- **Purpose**: Microservices and cloud-native systems
- **Visual Cue**: Orange hexagon represents modern cloud technology

```dsl
myCloudSystem = CloudNativeSystem "Payment Service" {
    // Automatically styled with orange cloud-native pattern
}
```

### Channel System Pattern
- **Color**: Integration Purple (#7B1FA2)
- **Shape**: Pipe (communication flow)
- **Border**: Thick (3px)
- **Purpose**: Communication and messaging systems
- **Visual Cue**: Purple pipe represents data/message flow

```dsl
myChannelSystem = ChannelSystem "Message Bus" {
    // Automatically styled with purple channel pattern
}
```

## 📦 Container Archetype Patterns

### Domain Container
- **Color**: Lighter Green (#4CAF50)
- **Shape**: Rounded Rectangle
- **Purpose**: Domain logic implementation
- **Hierarchy**: Nested within Domain Systems

### Enterprise Container
- **Color**: Lighter Blue (#1976D2)
- **Shape**: Rounded Rectangle
- **Purpose**: Enterprise-grade containers
- **Hierarchy**: Nested within Enterprise Systems

### Cloud Native Container
- **Color**: Lighter Orange (#FF8F00)
- **Shape**: Rounded Rectangle
- **Purpose**: Containerized applications
- **Hierarchy**: Nested within Cloud Native Systems

### Specialized Containers
- **API Gateway**: Teal Hexagon (#00695C)
- **Database**: Purple Cylinder (#5E35B1)
- **Cache**: Red Cylinder (#E53935)
- **Load Balancer**: Blue Hexagon (#1976D2)

## 🔗 Relationship Patterns

### Domain Flow
- **Color**: Green (#2E7D32)
- **Style**: Solid, Curved
- **Thickness**: 3px
- **Purpose**: Business process flows

### Enterprise Integration
- **Color**: Blue (#1565C0)
- **Style**: Solid, Orthogonal
- **Thickness**: 4px (thickest)
- **Purpose**: Governed enterprise connections

### Service Mesh
- **Color**: Orange (#FF6F00)
- **Style**: Solid, Curved
- **Thickness**: 2px
- **Purpose**: Microservice communication

### Message Flow
- **Color**: Purple (#7B1FA2)
- **Style**: Solid, Curved
- **Thickness**: 3px
- **Purpose**: Asynchronous messaging

### External API
- **Color**: Gray (#616161)
- **Style**: Dotted
- **Opacity**: 80%
- **Purpose**: Third-party integrations

## 🎯 Usage Guidelines

### Consistent Application
```dsl
// ✅ Good: Using archetype with automatic styling
paymentSystem = CloudNativeSystem "Payment Service" {
    // Inherits orange hexagon styling
    
    apiGateway = APIGatewayContainer "API Gateway" {
        // Inherits teal hexagon styling
    }
    
    database = DatabaseContainer "Payment DB" {
        // Inherits purple cylinder styling
    }
}

// Relationships inherit appropriate styling
paymentSystem -> externalBank "Processes payments" "HTTPS" "ExternalAPI"
```

### Visual Hierarchy
1. **System Level**: Boldest colors and thickest borders
2. **Container Level**: Lighter colors, medium borders
3. **Component Level**: Lightest colors, thin borders

### Color Coordination
- **Green Family**: Domain/Business systems
- **Blue Family**: Enterprise/Corporate systems
- **Orange Family**: Cloud/Modern systems
- **Purple Family**: Integration/Messaging systems
- **Gray Family**: External/Legacy systems

## 🔍 Pattern Recognition

Teams can instantly recognize:
- **Green Rounded Rectangles** = Domain Systems
- **Blue Thick Borders** = Enterprise Systems
- **Orange Hexagons** = Cloud Native Systems
- **Purple Pipes** = Channel Systems
- **Teal Hexagons** = API Gateways
- **Cylinders** = Data Storage

## 📏 Customization Guidelines

### Team Extensions
Teams can extend patterns while maintaining core identity:

```dsl
// Extend base archetype
MyTeamSystem = DomainSystem "My Team System" {
    // Inherits green domain styling
    
    // Add team-specific properties
    properties {
        "team.name" "My Team"
        "custom.property" "Team Value"
    }
}
```

### Style Overrides
Only override styles when absolutely necessary:

```dsl
styles {
    element "MyTeamSpecific" {
        // Override only if needed
        background "#custom-color"
        // Keep other archetype properties
    }
}
```

## 🚀 Benefits

1. **Instant Recognition**: Teams immediately understand system types
2. **Visual Consistency**: All projects follow same patterns
3. **Reduced Cognitive Load**: Familiar patterns across diagrams
4. **Better Communication**: Stakeholders understand visual language
5. **Scalable Standards**: Patterns work at any complexity level

## 📋 Pattern Checklist

- [ ] System uses appropriate archetype
- [ ] Colors match pattern guidelines
- [ ] Shapes convey correct meaning
- [ ] Relationships use semantic styling
- [ ] Visual hierarchy is maintained
- [ ] Custom styles are minimal
- [ ] Patterns are consistently applied
