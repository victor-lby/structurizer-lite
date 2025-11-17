# C4 Framework Update Guide

This guide explains how to update the C4 Framework archetypes, styles, themes, and other resources when the framework is updated.

## Overview

The C4 Framework auto-injection feature uses **dynamic classpath scanning** to automatically discover framework resources at runtime. When you add new framework files to the `src/main/resources/c4framework/` directory, they will be automatically detected and included without requiring code changes.

The implementation uses Spring's `PathMatchingResourcePatternResolver` to scan for `.dsl` and `.json` files in the framework subdirectories. A hardcoded fallback list is maintained for compatibility in case scanning fails in some environments.

## Update Process

### Step 1: Add New Framework Files

Simply add your new framework files to the appropriate subdirectory:

```bash
# Navigate to the framework resources directory
cd src/main/resources/c4framework/

# Add files to the appropriate subdirectories:
# - persons/       (person archetypes - .dsl files)
# - systems/       (system archetypes - .dsl files)
# - containers/    (container archetypes - .dsl files)
# - components/    (component archetypes - .dsl files)
# - styles/        (element and relationship styles - .dsl files)
# - terminology/   (terminology definitions - .dsl files)
# - themes/        (JSON theme files - .json files)
```

**Example:** If you add a new person archetype file `new-person.dsl`, place it in:
```
src/main/resources/c4framework/persons/new-person.dsl
```

**That's it!** The dynamic scanning will automatically discover and include the new file.

### Step 2: Rebuild and Test

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

### How Dynamic Scanning Works

The implementation uses Spring's `PathMatchingResourcePatternResolver` to scan classpath resources:

1. **Automatic Discovery**: On first workspace load, the system scans for all `.dsl` files in archetype subdirectories and `.json` files in the themes subdirectory
2. **Caching**: Discovered files are cached in memory to avoid repeated scanning
3. **Sorted Output**: Files are automatically sorted alphabetically for consistent DSL generation
4. **Fallback**: If scanning fails (rare edge case), the system falls back to a hardcoded list

**Benefits:**
- **Zero maintenance** - just add files to the resources directory
- **Works in all environments** - IDE, fat JAR, Docker
- **Automatic logging** - see discovered files in application logs
- **Predictable behavior** - sorted, deduplicated results

### Hardcoded Fallback List

A hardcoded fallback list is maintained in `C4FrameworkService.getHardcodedResourceFiles()` for compatibility. This list is only used if dynamic scanning fails (which should be extremely rare).

**When to update the fallback list:**
- If you want to ensure compatibility in exotic deployment scenarios
- If you notice scanning failures in your environment
- As a best practice when adding many new files

The fallback list is NOT required for normal operation - dynamic scanning handles everything automatically.

### Troubleshooting

**Problem:** New archetype file not appearing in generated DSL

**Solution:** 
1. Verify the file exists in `src/main/resources/c4framework/[subdirectory]/`
2. Check the file extension is correct (`.dsl` for archetypes, `.json` for themes)
3. Rebuild the project: `./gradlew clean build`
4. Rebuild Docker image: `docker build -t structurizr-lite-c4framework:latest .`
5. Check Docker logs for "Discovered" messages: `docker logs structurizr-c4 | grep Discovered`

**Problem:** Dynamic scanning not finding files

**Solution:**
1. Verify the file was included in the WAR: `jar tf build/libs/structurizr-lite.war | grep c4framework`
2. Check Docker logs for scanning errors: `docker logs structurizr-c4 | grep "Resource scan failed"`
3. The system will automatically fall back to the hardcoded list if scanning fails
4. Check application logs for "falling back to hardcoded list" warning

**Problem:** Framework extraction fails with "Resource not found"

**Solution:**
1. Check the filename spelling matches exactly (case-sensitive)
2. Verify the file was included in the WAR: `jar tf build/libs/structurizr-lite.war | grep c4framework`
3. Check Docker logs: `docker logs structurizr-c4 | grep ERROR`

## Quick Reference Commands

```bash
# List current framework files in resources
find src/main/resources/c4framework/ -type f \( -name "*.dsl" -o -name "*.json" \)

# Count files per subdirectory
ls src/main/resources/c4framework/persons/ | wc -l
ls src/main/resources/c4framework/systems/ | wc -l
ls src/main/resources/c4framework/containers/ | wc -l
ls src/main/resources/c4framework/components/ | wc -l

# Verify files in built WAR
jar tf build/libs/structurizr-lite.war | grep c4framework | sort

# Check extracted files in running container
docker exec structurizr-c4 find /usr/local/structurizr/.structurizr/c4framework/ -type f | sort

# View dynamic scanning logs
docker logs structurizr-c4 | grep "Discovered"

# Example output:
# Discovered 9 c4framework/persons resources: [agente-externo-person.dsl, ...]
# Discovered 5 c4framework/systems resources: [...]
# Discovered 10 c4framework/containers resources: [...]
```

## Contact

For questions or issues with the C4 Framework auto-injection feature, refer to:
- PR: https://github.com/victor-lby/structurizer-lite/pull/2
- Devin Session: https://app.devin.ai/sessions/513275b03b0242bea68b512ac175b234
