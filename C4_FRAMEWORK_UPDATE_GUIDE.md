# C4 Framework Update Guide

This guide explains how to update the C4 Framework archetypes, styles, themes, and other resources when the framework is updated.

## Overview

The C4 Framework auto-injection feature extracts framework resources from the JAR file to the filesystem at runtime. The list of files to extract is **hardcoded** in the `C4FrameworkService.java` file, so when the framework is updated with new files, you need to update the code manually.

## Update Process

### Step 1: Update Framework Resource Files

First, update the framework resource files in the project:

```bash
# Navigate to the framework resources directory
cd src/main/resources/c4framework/

# Update the files in the appropriate subdirectories:
# - persons/       (person archetypes)
# - systems/       (system archetypes)
# - containers/    (container archetypes)
# - components/    (component archetypes)
# - styles/        (element and relationship styles)
# - terminology/   (terminology definitions)
# - themes/        (JSON theme files)
```

**Example:** If you add a new person archetype file `new-person.dsl`, place it in:
```
src/main/resources/c4framework/persons/new-person.dsl
```

### Step 2: Update Hardcoded File Lists

Open the file:
```
src/main/java/com/structurizr/lite/component/workspace/C4FrameworkService.java
```

Find the `getHardcodedResourceFiles()` method (around line 341) and update the appropriate case statement.

#### Example: Adding a New Person Archetype

If you added `new-person.dsl` to the `persons/` directory:

**Before:**
```java
case "persons":
    return Arrays.asList(
        "agente-externo-person.dsl",
        "arquiteto-person.dsl",
        "cliente-person.dsl",
        "consultor-person.dsl",
        "desenvolvedor-person.dsl",
        "diretor-person.dsl",
        "gerente-loja-person.dsl",
        "gerente-regional-person.dsl",
        "gerente-territorial-person.dsl"
    );
```

**After:**
```java
case "persons":
    return Arrays.asList(
        "agente-externo-person.dsl",
        "arquiteto-person.dsl",
        "cliente-person.dsl",
        "consultor-person.dsl",
        "desenvolvedor-person.dsl",
        "diretor-person.dsl",
        "gerente-loja-person.dsl",
        "gerente-regional-person.dsl",
        "gerente-territorial-person.dsl",
        "new-person.dsl"  // <-- Add new file here
    );
```

#### Example: Adding a New Container Archetype

If you added `kafka-container.dsl` to the `containers/` directory:

```java
case "containers":
    return Arrays.asList(
        "apigateway-container.dsl",
        "cosmosdb-container.dsl",
        "cosmosdb-postgres-container.dsl",
        "eventhub-container.dsl",
        "kafka-container.dsl",  // <-- Add new file here
        "keyvault-container.dsl",
        "microservice-java-container.dsl",
        "microservice-node-container.dsl",
        "mongodb-atlas-container.dsl",
        "redis-container.dsl",
        "servicebus-container.dsl"
    );
```

#### Example: Adding a New Theme

If you added `c4-framework-custom.json` to the `themes/` directory:

```java
case "themes":
    return Arrays.asList(
        "c4-framework-default.json",
        "c4-framework-colorful.json",
        "c4-framework-dark.json",
        "c4-framework-custom.json"  // <-- Add new file here
    );
```

**Important:** Also update the `generateThemeReferences()` method (around line 298) to include the new theme in the generated DSL:

```java
private String generateThemeReferences() {
    String indent = "        ";
    StringBuilder themes = new StringBuilder();
    
    themes.append(indent).append("themes ")
          .append("c4framework/themes/c4-framework-default.json ")
          .append("c4framework/themes/c4-framework-colorful.json ")
          .append("c4framework/themes/c4-framework-dark.json ")
          .append("c4framework/themes/c4-framework-custom.json\n");  // <-- Add here
    
    return themes.toString();
}
```

### Step 3: Rebuild and Test

After updating the code:

```bash
# 1. Rebuild the project
./gradlew clean build

# 2. Rebuild Docker image
docker build -t structurizr-lite-c4framework:latest .

# 3. Run Docker container
docker stop structurizr-c4 && docker rm structurizr-c4
docker run -d -p 8080:8080 -v $(pwd)/workspace:/usr/local/structurizr --name structurizr-c4 structurizr-lite-c4framework:latest

# 4. Verify extraction
docker logs structurizr-c4 | grep "C4 Framework"
docker exec structurizr-c4 ls -la /usr/local/structurizr/.structurizr/c4framework/

# 5. Test in browser
# Open http://localhost:8080 and verify new archetypes/themes are available
```

### Step 4: Verify New Files Are Extracted

Check that the new files were extracted correctly:

```bash
# List files in the specific subdirectory
docker exec structurizr-c4 ls /usr/local/structurizr/.structurizr/c4framework/persons/
docker exec structurizr-c4 ls /usr/local/structurizr/.structurizr/c4framework/containers/
docker exec structurizr-c4 ls /usr/local/structurizr/.structurizr/c4framework/themes/

# Verify the new file exists
docker exec structurizr-c4 cat /usr/local/structurizr/.structurizr/c4framework/persons/new-person.dsl
```

## Complete File List Reference

### Current Framework Files (as of this implementation)

**Persons (9 files):**
- agente-externo-person.dsl
- arquiteto-person.dsl
- cliente-person.dsl
- consultor-person.dsl
- desenvolvedor-person.dsl
- diretor-person.dsl
- gerente-loja-person.dsl
- gerente-regional-person.dsl
- gerente-territorial-person.dsl

**Systems (5 files):**
- azure-service-system.dsl
- bounded-context.dsl
- channel-system.dsl
- external-resource-system.dsl
- on-premise-system.dsl

**Containers (10 files):**
- apigateway-container.dsl
- cosmosdb-container.dsl
- cosmosdb-postgres-container.dsl
- eventhub-container.dsl
- keyvault-container.dsl
- microservice-java-container.dsl
- microservice-node-container.dsl
- mongodb-atlas-container.dsl
- redis-container.dsl
- servicebus-container.dsl

**Components (10 files):**
- cosmosdb-collection-component.dsl
- cosmosdb-postgres-table-component.dsl
- event-component.dsl
- eventhub-topic-component.dsl
- message-component.dsl
- microservice-restapi-component.dsl
- microservice-soap-component.dsl
- mongodb-atlas-collection-component.dsl
- redis-instance-component.dsl
- servicebus-queue-component.dsl

**Styles (2 files):**
- element-styles.dsl
- relationship-styles.dsl

**Terminology (1 file):**
- definitions.dsl

**Themes (3 files):**
- c4-framework-default.json
- c4-framework-colorful.json
- c4-framework-dark.json

## Important Notes

### Why Hardcoded Lists?

The current implementation uses hardcoded file lists because:
1. **Classpath scanning is complex** in Spring Boot fat JARs
2. **Predictable behavior** - you know exactly which files will be extracted
3. **Performance** - no runtime directory scanning needed
4. **Explicit control** - you decide which files to include

### Future Improvements

Consider these improvements for easier maintenance:

1. **Automated file list generation**: Create a Gradle task that scans the `src/main/resources/c4framework/` directory and generates the hardcoded lists automatically during build.

2. **Runtime directory scanning**: Implement classpath resource scanning to automatically discover framework files (more complex but eliminates manual updates).

3. **Configuration file**: Move the file lists to a JSON/YAML configuration file that's easier to update.

4. **Validation script**: Create a script that compares the files in `src/main/resources/c4framework/` with the hardcoded lists and warns about mismatches.

### Troubleshooting

**Problem:** New archetype file not appearing in generated DSL

**Solution:** 
1. Verify the file exists in `src/main/resources/c4framework/[subdirectory]/`
2. Check that the filename is added to the hardcoded list in `getHardcodedResourceFiles()`
3. Rebuild the project: `./gradlew clean build`
4. Rebuild Docker image: `docker build -t structurizr-lite-c4framework:latest .`
5. Remove old container and create new one

**Problem:** Framework extraction fails with "Resource not found"

**Solution:**
1. Check the filename spelling in the hardcoded list matches exactly (case-sensitive)
2. Verify the file was included in the WAR: `jar tf build/libs/structurizr-lite.war | grep c4framework`
3. Check Docker logs: `docker logs structurizr-c4 | grep ERROR`

## Quick Reference Commands

```bash
# List current framework files in resources
find src/main/resources/c4framework/ -type f -name "*.dsl" -o -name "*.json"

# Count files per subdirectory
ls src/main/resources/c4framework/persons/ | wc -l
ls src/main/resources/c4framework/systems/ | wc -l
ls src/main/resources/c4framework/containers/ | wc -l
ls src/main/resources/c4framework/components/ | wc -l

# Verify files in built WAR
jar tf build/libs/structurizr-lite.war | grep c4framework | sort

# Check extracted files in running container
docker exec structurizr-c4 find /usr/local/structurizr/.structurizr/c4framework/ -type f | sort
```

## Contact

For questions or issues with the C4 Framework auto-injection feature, refer to:
- PR: https://github.com/victor-lby/structurizer-lite/pull/2
- Devin Session: https://app.devin.ai/sessions/513275b03b0242bea68b512ac175b234
