# Implementation Plan: Embedding C4 Framework in Structurizr Lite

## Task Assessment

### Objective
Embed the c4framework within the Structurizr Lite environment so that users don't need to manually include framework files every time they build a `.dsl` file. The goal is to make the framework's archetypes, styles, and themes automatically available to all workspace DSL files.

### Current State Analysis

**What Users Currently Need to Do:**
When creating a new workspace DSL file, users must manually include the c4framework components:

```dsl
workspace "My Architecture" {
    model {
        archetypes {
            !include "./c4framework/persons/consultor-person.dsl"
            !include "./c4framework/systems/bounded-context.dsl"
            !include "./c4framework/containers/microservice-java-container.dsl"
            // ... 30+ more includes
        }
    }
    
    views {
        styles {
            !include "./c4framework/styles/element-styles.dsl"
            !include "./c4framework/styles/relationship-styles.dsl"
        }
        !include "./c4framework/terminology/definitions.dsl"
        themes "./c4framework/themes/c4-framework-colorful.json"
    }
}
```

**Challenges with Current Approach:**
1. **Repetitive Boilerplate:** Every workspace must include 39+ framework files
2. **Path Management:** Users must maintain correct relative paths to c4framework
3. **Framework Updates:** Updating the framework requires changes to all workspace files
4. **Error-Prone:** Easy to forget includes or use incorrect paths
5. **Inconsistency:** Different workspaces may include different subsets of the framework

**Desired State:**
Users should be able to create workspace DSL files that automatically have access to all c4framework archetypes, styles, and themes without explicit includes:

```dsl
workspace "My Architecture" {
    model {
        // Archetypes automatically available
        customer = ConsultorPerson "Customer" "Business consultant"
        
        system = BoundedContext "Order Management" "Handles orders"
        
        api = MicroserviceJavaContainer "Order API" "REST API"
    }
    
    views {
        // Styles and themes automatically applied
        systemContext system {
            include *
        }
    }
}
```

## Technical Analysis

### How Structurizr DSL Parser Works

Based on the code analysis, the DSL parsing flow is:

1. **Entry Point:** `FileSystemWorkspaceComponentImpl.loadWorkspaceFromDsl()` (line 173)
2. **Parser Creation:** Creates `StructurizrDslParser` instance
3. **File Parsing:** Calls `parser.parse(dslFile)` on the workspace DSL file
4. **Include Resolution:** Parser resolves `!include` directives relative to the DSL file location
5. **Workspace Generation:** Returns parsed `Workspace` object

**Key Observations:**
- The parser is part of the external `structurizr-dsl` library (v5.0.1)
- Include paths are resolved relative to the DSL file being parsed
- The parser has HTTP client support for remote includes
- No built-in mechanism for "global" or "default" includes

### Implementation Approaches

I've identified four potential approaches, each with different trade-offs:

#### Approach 1: DSL Template Injection (Recommended)
**Concept:** Automatically prepend c4framework includes to user workspace DSL files during parsing.

**Implementation:**
1. Create a framework template file with all c4framework includes
2. Modify `FileSystemWorkspaceComponentImpl.loadWorkspaceFromDsl()` to:
   - Read the user's workspace DSL file
   - Detect if it already includes the framework (to avoid duplication)
   - If not, prepend the framework template before parsing
   - Parse the combined DSL content

**Pros:**
- ✓ Transparent to users - no changes to existing workspace files
- ✓ Framework updates automatically propagate to all workspaces
- ✓ Users can opt-out by explicitly including framework themselves
- ✓ No changes to structurizr-dsl library required
- ✓ Maintains backward compatibility

**Cons:**
- ✗ Requires modification to Structurizr Lite source code
- ✗ Adds slight parsing overhead
- ✗ May complicate error messages (line numbers shift)

**Complexity:** Medium

#### Approach 2: Workspace Preprocessing Hook
**Concept:** Add a preprocessing step that generates a complete DSL file with framework includes before parsing.

**Implementation:**
1. Create a `.structurizr/framework-config.properties` file to enable/disable framework
2. When loading a workspace:
   - Check if framework is enabled
   - Generate a temporary DSL file combining framework + user workspace
   - Parse the temporary file
   - Clean up temporary file after parsing

**Pros:**
- ✓ Clean separation of concerns
- ✓ Easy to enable/disable per workspace
- ✓ Original user files remain unchanged
- ✓ Framework updates automatically propagate

**Cons:**
- ✗ Requires temporary file management
- ✗ More complex implementation
- ✗ Potential file system race conditions in multi-user scenarios

**Complexity:** Medium-High

#### Approach 3: Custom DSL Parser Extension
**Concept:** Extend or wrap the StructurizrDslParser to add framework support.

**Implementation:**
1. Create a `C4FrameworkDslParser` that extends `StructurizrDslParser`
2. Override the `parse()` method to:
   - First parse a framework DSL file
   - Then parse the user's workspace DSL file
   - Merge the two workspaces

**Pros:**
- ✓ Clean object-oriented design
- ✓ Easy to test and maintain
- ✓ Framework can be versioned separately

**Cons:**
- ✗ Workspace merging is complex (archetypes, styles, views)
- ✗ May not be possible if StructurizrDslParser is final or has private methods
- ✗ Requires deep understanding of Workspace object structure
- ✗ Risk of conflicts between framework and user definitions

**Complexity:** High

#### Approach 4: Global Framework Directory
**Concept:** Place c4framework in a global location and use absolute paths or environment variables.

**Implementation:**
1. Move c4framework to a well-known location (e.g., `/usr/local/structurizr/framework/`)
2. Configure Structurizr Lite to set an environment variable or constant
3. Users reference framework using: `!include "${FRAMEWORK_HOME}/persons/consultor-person.dsl"`

**Pros:**
- ✓ Simple implementation
- ✓ No code changes to Structurizr Lite
- ✓ Framework centrally managed

**Cons:**
- ✗ Users still need to write includes (doesn't solve the main problem)
- ✗ Requires environment configuration
- ✗ Less portable across different installations
- ✗ Not truly "embedded" - just centralized

**Complexity:** Low

## Recommended Solution

### Primary Recommendation: Approach 1 (DSL Template Injection)

This approach best balances user experience, implementation complexity, and maintainability.

### Implementation Details

#### Phase 1: Framework Organization (1-2 hours)

**1.1 Create Framework Bundle File**
Create a single DSL file that includes all framework components:

**Location:** `src/main/resources/c4framework/framework-bundle.dsl`

```dsl
// C4 Framework Bundle - Auto-included in all workspaces
// This file is automatically prepended to workspace DSL files

// Person Archetypes
!include "persons/consultor-person.dsl"
!include "persons/agente-externo-person.dsl"
!include "persons/arquiteto-person.dsl"
!include "persons/cliente-person.dsl"
!include "persons/desenvolvedor-person.dsl"
!include "persons/diretor-person.dsl"
!include "persons/gerente-loja-person.dsl"
!include "persons/gerente-regional-person.dsl"
!include "persons/gerente-territorial-person.dsl"

// System Archetypes
!include "systems/azure-service-system.dsl"
!include "systems/bounded-context.dsl"
!include "systems/channel-system.dsl"
!include "systems/external-resource-system.dsl"
!include "systems/on-premise-system.dsl"

// Container Archetypes
!include "containers/apigateway-container.dsl"
!include "containers/cosmosdb-container.dsl"
!include "containers/cosmosdb-postgres-container.dsl"
!include "containers/eventhub-container.dsl"
!include "containers/keyvault-container.dsl"
!include "containers/microservice-java-container.dsl"
!include "containers/microservice-node-container.dsl"
!include "containers/mongodb-atlas-container.dsl"
!include "containers/redis-container.dsl"
!include "containers/servicebus-container.dsl"

// Component Archetypes
!include "components/cosmosdb-collection-component.dsl"
!include "components/cosmosdb-postgres-table-component.dsl"
!include "components/event-component.dsl"
!include "components/eventhub-topic-component.dsl"
!include "components/message-component.dsl"
!include "components/microservice-restapi-component.dsl"
!include "components/microservice-soap-component.dsl"
!include "components/mongodb-atlas-collection-component.dsl"
!include "components/redis-instance-component.dsl"
!include "components/servicebus-queue-component.dsl"

// Styles
!include "styles/element-styles.dsl"
!include "styles/relationship-styles.dsl"

// Terminology
!include "terminology/definitions.dsl"

// Themes
themes "themes/c4-framework-default.json" "themes/c4-framework-colorful.json" "themes/c4-framework-dark.json"
```

**1.2 Move Framework to Resources**
Move the c4framework directory to the application resources:

```
src/main/resources/
└── c4framework/
    ├── framework-bundle.dsl (new)
    ├── persons/
    ├── systems/
    ├── containers/
    ├── components/
    ├── styles/
    ├── terminology/
    └── themes/
```

**1.3 Update Build Configuration**
Ensure c4framework is included in the WAR file:

```gradle
// In build.gradle, verify resources are included
sourceSets {
    main {
        resources {
            srcDirs = ['src/main/resources']
        }
    }
}
```

#### Phase 2: Configuration System (2-3 hours)

**2.1 Add Framework Configuration Properties**

Update `Configuration.java` to support framework configuration:

```java
// Add constants
private static final String C4_FRAMEWORK_ENABLED_PROPERTY = "structurizr.c4framework.enabled";
private static final String C4_FRAMEWORK_AUTO_INCLUDE_PROPERTY = "structurizr.c4framework.autoInclude";

// Add methods
public boolean isC4FrameworkEnabled() {
    return Boolean.parseBoolean(getConfigurationParameter(C4_FRAMEWORK_ENABLED_PROPERTY, "true"));
}

public boolean isC4FrameworkAutoInclude() {
    return Boolean.parseBoolean(getConfigurationParameter(C4_FRAMEWORK_AUTO_INCLUDE_PROPERTY, "true"));
}

public File getC4FrameworkDirectory() {
    // Return path to c4framework in resources
    return new File(getClass().getClassLoader().getResource("c4framework").getFile());
}
```

**2.2 Add Workspace-Level Override**

Allow users to opt-out per workspace via `structurizr.properties`:

```properties
# Enable/disable C4 framework globally
structurizr.c4framework.enabled=true

# Auto-include framework in all workspaces
structurizr.c4framework.autoInclude=true
```

#### Phase 3: DSL Processing Enhancement (4-6 hours)

**3.1 Create Framework Injection Service**

Create new class: `src/main/java/com/structurizr/lite/component/workspace/C4FrameworkService.java`

```java
package com.structurizr.lite.component.workspace;

import com.structurizr.lite.Configuration;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;

@Service
public class C4FrameworkService {
    
    private static final Log log = LogFactory.getLog(C4FrameworkService.class);
    private static final String FRAMEWORK_MARKER = "!c4framework";
    private static final String OPT_OUT_MARKER = "!c4framework:disable";
    
    /**
     * Checks if the workspace DSL file should have the framework injected.
     */
    public boolean shouldInjectFramework(File dslFile) {
        if (!Configuration.getInstance().isC4FrameworkEnabled()) {
            return false;
        }
        
        if (!Configuration.getInstance().isC4FrameworkAutoInclude()) {
            return false;
        }
        
        try {
            String content = Files.readString(dslFile.toPath(), StandardCharsets.UTF_8);
            
            // Don't inject if user explicitly opted out
            if (content.contains(OPT_OUT_MARKER)) {
                log.debug("C4 Framework injection disabled for: " + dslFile.getName());
                return false;
            }
            
            // Don't inject if already included
            if (content.contains("c4framework/") || content.contains(FRAMEWORK_MARKER)) {
                log.debug("C4 Framework already included in: " + dslFile.getName());
                return false;
            }
            
            return true;
        } catch (IOException e) {
            log.warn("Could not read DSL file for framework injection check: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Injects the C4 framework into the workspace DSL content.
     */
    public String injectFramework(String workspaceDslContent, File frameworkDirectory) {
        StringBuilder injected = new StringBuilder();
        
        // Add framework marker comment
        injected.append("// C4 Framework Auto-Injected\n");
        injected.append("// To disable: add '!c4framework:disable' to your workspace file\n\n");
        
        // Parse workspace declaration to inject framework in the right place
        String[] lines = workspaceDslContent.split("\n");
        boolean inWorkspace = false;
        boolean inModel = false;
        boolean frameworkInjected = false;
        
        for (String line : lines) {
            String trimmed = line.trim();
            
            // Detect workspace block
            if (trimmed.startsWith("workspace")) {
                injected.append(line).append("\n");
                inWorkspace = true;
                continue;
            }
            
            // Detect model block
            if (inWorkspace && trimmed.startsWith("model")) {
                injected.append(line).append("\n");
                inModel = true;
                
                // Inject archetypes at the start of model block
                injected.append("        archetypes {\n");
                injected.append(generateFrameworkIncludes(frameworkDirectory, "archetypes"));
                injected.append("        }\n\n");
                frameworkInjected = true;
                continue;
            }
            
            // Detect views block
            if (inWorkspace && trimmed.startsWith("views")) {
                injected.append(line).append("\n");
                
                // Inject styles and themes at the start of views block
                injected.append("        styles {\n");
                injected.append(generateFrameworkIncludes(frameworkDirectory, "styles"));
                injected.append("            theme default\n");
                injected.append("        }\n\n");
                injected.append(generateFrameworkIncludes(frameworkDirectory, "terminology"));
                injected.append(generateFrameworkThemes(frameworkDirectory));
                injected.append("\n");
                continue;
            }
            
            injected.append(line).append("\n");
        }
        
        if (!frameworkInjected) {
            log.warn("Could not inject C4 framework - workspace structure not recognized");
            return workspaceDslContent;
        }
        
        return injected.toString();
    }
    
    private String generateFrameworkIncludes(File frameworkDirectory, String type) {
        StringBuilder includes = new StringBuilder();
        String indent = "            ";
        
        try {
            if ("archetypes".equals(type)) {
                // Include persons
                includes.append(indent).append("// Person Archetypes\n");
                File personsDir = new File(frameworkDirectory, "persons");
                for (File file : personsDir.listFiles((dir, name) -> name.endsWith(".dsl"))) {
                    includes.append(indent).append("!include \"")
                           .append(frameworkDirectory.getAbsolutePath())
                           .append("/persons/").append(file.getName()).append("\"\n");
                }
                
                // Include systems
                includes.append(indent).append("\n").append(indent).append("// System Archetypes\n");
                File systemsDir = new File(frameworkDirectory, "systems");
                for (File file : systemsDir.listFiles((dir, name) -> name.endsWith(".dsl"))) {
                    includes.append(indent).append("!include \"")
                           .append(frameworkDirectory.getAbsolutePath())
                           .append("/systems/").append(file.getName()).append("\"\n");
                }
                
                // Include containers
                includes.append(indent).append("\n").append(indent).append("// Container Archetypes\n");
                File containersDir = new File(frameworkDirectory, "containers");
                for (File file : containersDir.listFiles((dir, name) -> name.endsWith(".dsl"))) {
                    includes.append(indent).append("!include \"")
                           .append(frameworkDirectory.getAbsolutePath())
                           .append("/containers/").append(file.getName()).append("\"\n");
                }
                
                // Include components
                includes.append(indent).append("\n").append(indent).append("// Component Archetypes\n");
                File componentsDir = new File(frameworkDirectory, "components");
                for (File file : componentsDir.listFiles((dir, name) -> name.endsWith(".dsl"))) {
                    includes.append(indent).append("!include \"")
                           .append(frameworkDirectory.getAbsolutePath())
                           .append("/components/").append(file.getName()).append("\"\n");
                }
            } else if ("styles".equals(type)) {
                File stylesDir = new File(frameworkDirectory, "styles");
                for (File file : stylesDir.listFiles((dir, name) -> name.endsWith(".dsl"))) {
                    includes.append(indent).append("!include \"")
                           .append(frameworkDirectory.getAbsolutePath())
                           .append("/styles/").append(file.getName()).append("\"\n");
                }
            } else if ("terminology".equals(type)) {
                includes.append(indent).append("!include \"")
                       .append(frameworkDirectory.getAbsolutePath())
                       .append("/terminology/definitions.dsl\"\n");
            }
        } catch (Exception e) {
            log.error("Error generating framework includes: " + e.getMessage(), e);
        }
        
        return includes.toString();
    }
    
    private String generateFrameworkThemes(File frameworkDirectory) {
        StringBuilder themes = new StringBuilder();
        String indent = "        ";
        
        themes.append(indent).append("themes \"")
              .append(frameworkDirectory.getAbsolutePath()).append("/themes/c4-framework-default.json\" \"")
              .append(frameworkDirectory.getAbsolutePath()).append("/themes/c4-framework-colorful.json\" \"")
              .append(frameworkDirectory.getAbsolutePath()).append("/themes/c4-framework-dark.json\"\n");
        
        return themes.toString();
    }
}
```

**3.2 Modify FileSystemWorkspaceComponentImpl**

Update the `loadWorkspaceFromDsl()` method:

```java
// Add field
private final C4FrameworkService c4FrameworkService;

// Update constructor
FileSystemWorkspaceComponentImpl(SearchComponent searchComponent, C4FrameworkService c4FrameworkService) {
    this.searchComponent = searchComponent;
    this.c4FrameworkService = c4FrameworkService;
    try {
        start();
    } catch (Exception e) {
        log.error("Error while starting Structurizr Lite", e);
    }
}

// Modify loadWorkspaceFromDsl method
private Workspace loadWorkspaceFromDsl(long workspaceId, File dslFile, File jsonFile) {
    Workspace workspace = null;

    try {
        // Check if we should inject the C4 framework
        String dslContent = null;
        if (c4FrameworkService.shouldInjectFramework(dslFile)) {
            String originalContent = Files.readString(dslFile.toPath(), StandardCharsets.UTF_8);
            File frameworkDir = Configuration.getInstance().getC4FrameworkDirectory();
            dslContent = c4FrameworkService.injectFramework(originalContent, frameworkDir);
            
            // Create temporary file with injected content
            File tempDslFile = File.createTempFile("workspace-", ".dsl", Configuration.getInstance().getWorkDirectory());
            Files.writeString(tempDslFile.toPath(), dslContent, StandardCharsets.UTF_8);
            dslFile = tempDslFile;
            
            log.info("C4 Framework auto-injected for workspace " + workspaceId);
        }
        
        StructurizrDslParser parser = new StructurizrDslParser();
        parser.getHttpClient().allow(".*");
        parser.getHttpClient().setTimeout(1000 * 60);
        parser.parse(dslFile);
        workspace = parser.getWorkspace();
        workspace.setId(workspaceId);

        // ... rest of existing code ...
        
    } catch (Exception e) {
        workspace = null;
        error = filename + ".dsl: " + e.getMessage();
        log.error(e);
    }

    return workspace;
}
```

#### Phase 4: Testing & Validation (3-4 hours)

**4.1 Unit Tests**

Create `src/test/java/com/structurizr/lite/component/workspace/C4FrameworkServiceTest.java`:

```java
@Test
public void shouldInjectFramework_WhenEnabledAndNoOptOut() {
    // Test framework injection logic
}

@Test
public void shouldNotInjectFramework_WhenOptOutMarkerPresent() {
    // Test opt-out functionality
}

@Test
public void shouldNotInjectFramework_WhenAlreadyIncluded() {
    // Test duplicate prevention
}

@Test
public void injectFramework_ShouldGenerateValidDsl() {
    // Test DSL generation
}
```

**4.2 Integration Tests**

Create test workspace files:
- `test-workspace-simple.dsl` - Basic workspace without framework
- `test-workspace-with-framework.dsl` - Workspace that already includes framework
- `test-workspace-opt-out.dsl` - Workspace with opt-out marker

**4.3 Manual Testing Checklist**

- [ ] Create new workspace without framework includes - verify archetypes available
- [ ] Create workspace with explicit framework includes - verify no duplication
- [ ] Create workspace with opt-out marker - verify framework not injected
- [ ] Disable framework via configuration - verify no injection
- [ ] Test with multiple workspaces - verify isolation
- [ ] Test framework updates - verify changes propagate
- [ ] Test error handling - verify graceful degradation

#### Phase 5: Documentation (2-3 hours)

**5.1 Update README.md**

Add section on C4 Framework:

```markdown
## C4 Framework

Structurizr Lite includes an embedded C4 Framework with reusable archetypes for:
- Person archetypes (9 role-based personas)
- System archetypes (5 deployment patterns)
- Container archetypes (10 infrastructure patterns)
- Component archetypes (10 component patterns)
- Comprehensive styling system
- Custom themes

### Automatic Inclusion

The C4 Framework is automatically included in all workspace DSL files. You can use archetypes directly:

```dsl
workspace "My Architecture" {
    model {
        customer = ConsultorPerson "Customer" "Business consultant"
        system = BoundedContext "Order Management" "Handles orders"
    }
    views {
        systemContext system {
            include *
        }
    }
}
```

### Disabling Auto-Inclusion

To disable automatic framework inclusion for a specific workspace, add this comment at the top of your DSL file:

```dsl
!c4framework:disable

workspace "My Architecture" {
    // Your workspace definition
}
```

To disable globally, add to `structurizr.properties`:

```properties
structurizr.c4framework.autoInclude=false
```

### Available Archetypes

[List all archetypes with descriptions]
```

**5.2 Create Framework Documentation**

Create `docs/C4_FRAMEWORK.md` with:
- Complete archetype reference
- Usage examples
- Styling guide
- Theme customization
- Best practices

**5.3 Add Inline Documentation**

Add JavaDoc comments to all new classes and methods.

#### Phase 6: Deployment & Rollout (1-2 hours)

**6.1 Build & Package**

```bash
./gradlew clean build
./gradlew bootWar
```

**6.2 Docker Image Update**

Update Dockerfile if needed to ensure c4framework resources are included.

**6.3 Release Notes**

Document the new feature:
- What's new
- How to use
- Migration guide for existing workspaces
- Breaking changes (if any)

## Alternative: Simplified Approach

If the full implementation is too complex, consider this simplified approach:

### Quick Win: Framework Template Generator

Create a command-line tool or web UI feature that generates workspace files with framework includes:

**Implementation:**
1. Add a "New Workspace" button in the UI
2. Provide template options:
   - "Blank workspace"
   - "Workspace with C4 Framework"
   - "Workspace with C4 Framework (minimal)"
3. Generate DSL file with appropriate includes

**Pros:**
- Much simpler implementation (1-2 days)
- No parser modifications needed
- Users still have full control

**Cons:**
- Doesn't fully solve the problem (users still see includes)
- Framework updates require workspace regeneration

## Risk Assessment

### Technical Risks

| Risk | Probability | Impact | Mitigation |
|------|------------|--------|------------|
| Parser compatibility issues | Medium | High | Thorough testing with various DSL structures |
| Performance degradation | Low | Medium | Benchmark parsing times, optimize if needed |
| Framework conflicts with user definitions | Medium | Medium | Clear naming conventions, opt-out mechanism |
| Resource loading issues in WAR deployment | Low | High | Test in production-like environment |
| Line number misalignment in error messages | High | Low | Implement error message translation |

### User Experience Risks

| Risk | Probability | Impact | Mitigation |
|------|------------|--------|------------|
| Users confused by auto-injection | Medium | Low | Clear documentation, visible markers |
| Existing workspaces break | Low | High | Backward compatibility, gradual rollout |
| Framework too opinionated | Medium | Medium | Easy opt-out, customization options |
| Performance issues with large frameworks | Low | Medium | Lazy loading, caching strategies |

## Success Criteria

### Functional Requirements
- [ ] Users can create workspaces without explicit framework includes
- [ ] All 39 framework archetypes are available automatically
- [ ] Styles and themes are applied automatically
- [ ] Users can opt-out per workspace or globally
- [ ] Existing workspaces continue to work without changes
- [ ] Framework updates propagate to all workspaces

### Non-Functional Requirements
- [ ] Parsing performance impact < 10%
- [ ] No breaking changes to existing API
- [ ] Comprehensive test coverage (>80%)
- [ ] Clear documentation and examples
- [ ] Graceful error handling and fallback

### User Acceptance Criteria
- [ ] New users can create workspaces faster
- [ ] Reduced boilerplate code in workspace files
- [ ] Consistent styling across all workspaces
- [ ] Easy to understand and debug

## Timeline Estimate

| Phase | Duration | Dependencies |
|-------|----------|--------------|
| Phase 1: Framework Organization | 1-2 hours | None |
| Phase 2: Configuration System | 2-3 hours | Phase 1 |
| Phase 3: DSL Processing Enhancement | 4-6 hours | Phase 1, 2 |
| Phase 4: Testing & Validation | 3-4 hours | Phase 3 |
| Phase 5: Documentation | 2-3 hours | Phase 4 |
| Phase 6: Deployment & Rollout | 1-2 hours | Phase 5 |
| **Total** | **13-20 hours** | |

**Note:** Timeline assumes familiarity with the codebase and no major blockers. Add 20-30% buffer for unexpected issues.

## Conclusion

Embedding the C4 Framework in Structurizr Lite is technically feasible and will significantly improve user experience. The recommended approach (DSL Template Injection) provides the best balance of functionality, maintainability, and user experience.

The implementation requires moderate effort but delivers substantial value:
- **User Benefit:** Eliminates repetitive boilerplate, reduces errors, ensures consistency
- **Maintenance Benefit:** Centralized framework management, easier updates
- **Scalability:** Framework can grow without impacting user workspaces

The key to success is thorough testing, clear documentation, and providing easy opt-out mechanisms for users who need more control.
