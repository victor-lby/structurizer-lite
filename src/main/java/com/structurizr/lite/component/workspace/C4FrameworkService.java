package com.structurizr.lite.component.workspace;

import com.structurizr.lite.Configuration;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service for managing C4 Framework integration with workspace DSL files.
 * Provides automatic injection of framework archetypes, styles, and themes.
 */
@Service
public class C4FrameworkService {
    
    private static final Log log = LogFactory.getLog(C4FrameworkService.class);
    
    private static final String FRAMEWORK_MARKER = "!c4framework";
    private static final String OPT_OUT_MARKER = "!c4framework:disable";
    private static final String FRAMEWORK_PATH = "c4framework";
    
    private volatile boolean frameworkExtracted = false;
    
    /**
     * Checks if the workspace DSL file should have the framework injected.
     * 
     * @param dslFile The DSL file to check
     * @return true if framework should be injected, false otherwise
     */
    public boolean shouldInjectFramework(File dslFile) {
        if (!Configuration.getInstance().isC4FrameworkEnabled()) {
            log.debug("C4 Framework is disabled globally");
            return false;
        }
        
        if (!Configuration.getInstance().isC4FrameworkAutoInclude()) {
            log.debug("C4 Framework auto-include is disabled");
            return false;
        }
        
        try {
            String content = Files.readString(dslFile.toPath(), StandardCharsets.UTF_8);
            
            if (content.contains(OPT_OUT_MARKER)) {
                log.debug("C4 Framework injection disabled for: " + dslFile.getName());
                return false;
            }
            
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
     * Extracts framework resources from classpath to the work directory.
     * This is necessary because Structurizr DSL parser doesn't support classpath includes.
     */
    private void extractFrameworkResources() {
        if (frameworkExtracted) {
            return;
        }
        
        synchronized (this) {
            if (frameworkExtracted) {
                return;
            }
            
            try {
                File workDir = Configuration.getInstance().getWorkDirectory();
                File frameworkDir = new File(workDir, FRAMEWORK_PATH);
                
                if (frameworkDir.exists()) {
                    frameworkExtracted = true;
                    log.debug("C4 Framework resources already extracted to: " + frameworkDir.getAbsolutePath());
                    return;
                }
                
                log.info("Extracting C4 Framework resources to: " + frameworkDir.getAbsolutePath());
                
                extractResourceDirectory("persons");
                extractResourceDirectory("systems");
                extractResourceDirectory("containers");
                extractResourceDirectory("components");
                extractResourceDirectory("styles");
                extractResourceDirectory("terminology");
                extractResourceDirectory("themes");
                
                frameworkExtracted = true;
                log.info("C4 Framework resources extracted successfully");
                
            } catch (Exception e) {
                log.error("Failed to extract C4 Framework resources: " + e.getMessage(), e);
            }
        }
    }
    
    /**
     * Extracts all files from a framework subdirectory to the work directory.
     */
    private void extractResourceDirectory(String subdirectory) throws IOException {
        File workDir = Configuration.getInstance().getWorkDirectory();
        File targetDir = new File(workDir, FRAMEWORK_PATH + "/" + subdirectory);
        
        if (!targetDir.exists()) {
            targetDir.mkdirs();
        }
        
        List<String> files = getHardcodedResourceFiles(subdirectory);
        
        for (String filename : files) {
            String resourcePath = FRAMEWORK_PATH + "/" + subdirectory + "/" + filename;
            File targetFile = new File(targetDir, filename);
            
            if (targetFile.exists()) {
                continue;
            }
            
            try (InputStream is = getClass().getClassLoader().getResourceAsStream(resourcePath)) {
                if (is != null) {
                    Files.copy(is, targetFile.toPath());
                    log.debug("Extracted: " + resourcePath + " -> " + targetFile.getAbsolutePath());
                } else {
                    log.warn("Resource not found in classpath: " + resourcePath);
                }
            }
        }
    }
    
    /**
     * Injects the C4 framework into the workspace DSL content.
     * 
     * @param workspaceDslContent The original workspace DSL content
     * @return The DSL content with framework injected
     */
    public String injectFramework(String workspaceDslContent) {
        extractFrameworkResources();
        
        StringBuilder injected = new StringBuilder();
        
        injected.append("// C4 Framework Auto-Injected\n");
        injected.append("// To disable: add '!c4framework:disable' to your workspace file\n\n");
        
        String[] lines = workspaceDslContent.split("\n");
        boolean inWorkspace = false;
        boolean inModel = false;
        boolean inViews = false;
        boolean frameworkArchetypesInjected = false;
        boolean frameworkStylesInjected = false;
        int indentLevel = 0;
        
        for (int i = 0; i < lines.length; i++) {
            String line = lines[i];
            String trimmed = line.trim();
            
            if (trimmed.startsWith("workspace")) {
                injected.append(line).append("\n");
                inWorkspace = true;
                continue;
            }
            
            if (inWorkspace && trimmed.startsWith("model") && trimmed.contains("{")) {
                injected.append(line).append("\n");
                inModel = true;
                
                injected.append("        archetypes {\n");
                injected.append(generateArchetypeIncludes());
                injected.append("        }\n\n");
                frameworkArchetypesInjected = true;
                continue;
            }
            
            if (inModel && trimmed.equals("}")) {
                inModel = false;
            }
            
            if (inWorkspace && !inModel && trimmed.startsWith("views") && trimmed.contains("{")) {
                injected.append(line).append("\n");
                inViews = true;
                
                injected.append("        styles {\n");
                injected.append(generateStyleIncludes());
                injected.append("            theme default\n");
                injected.append("        }\n\n");
                injected.append(generateTerminologyInclude());
                injected.append(generateThemeReferences());
                injected.append("\n");
                frameworkStylesInjected = true;
                continue;
            }
            
            if (inViews && trimmed.equals("}")) {
                inViews = false;
            }
            
            injected.append(line).append("\n");
        }
        
        if (!frameworkArchetypesInjected) {
            log.warn("Could not inject C4 framework archetypes - model block not found");
        }
        
        if (!frameworkStylesInjected) {
            log.warn("Could not inject C4 framework styles - views block not found");
        }
        
        return injected.toString();
    }
    
    /**
     * Generates include statements for all framework archetypes.
     */
    private String generateArchetypeIncludes() {
        StringBuilder includes = new StringBuilder();
        String indent = "            ";
        
        try {
            includes.append(indent).append("// Person Archetypes\n");
            List<String> personFiles = getHardcodedResourceFiles("persons");
            for (String file : personFiles) {
                includes.append(indent).append("!include c4framework/persons/")
                       .append(file).append("\n");
            }
            
            includes.append(indent).append("\n").append(indent).append("// System Archetypes\n");
            List<String> systemFiles = getHardcodedResourceFiles("systems");
            for (String file : systemFiles) {
                includes.append(indent).append("!include c4framework/systems/")
                       .append(file).append("\n");
            }
            
            includes.append(indent).append("\n").append(indent).append("// Container Archetypes\n");
            List<String> containerFiles = getHardcodedResourceFiles("containers");
            for (String file : containerFiles) {
                includes.append(indent).append("!include c4framework/containers/")
                       .append(file).append("\n");
            }
            
            includes.append(indent).append("\n").append(indent).append("// Component Archetypes\n");
            List<String> componentFiles = getHardcodedResourceFiles("components");
            for (String file : componentFiles) {
                includes.append(indent).append("!include c4framework/components/")
                       .append(file).append("\n");
            }
            
        } catch (Exception e) {
            log.error("Error generating framework archetype includes: " + e.getMessage(), e);
        }
        
        return includes.toString();
    }
    
    /**
     * Generates include statements for framework styles.
     */
    private String generateStyleIncludes() {
        StringBuilder includes = new StringBuilder();
        String indent = "            ";
        
        try {
            List<String> styleFiles = getHardcodedResourceFiles("styles");
            for (String file : styleFiles) {
                includes.append(indent).append("!include c4framework/styles/")
                       .append(file).append("\n");
            }
        } catch (Exception e) {
            log.error("Error generating framework style includes: " + e.getMessage(), e);
        }
        
        return includes.toString();
    }
    
    /**
     * Generates include statement for framework terminology.
     */
    private String generateTerminologyInclude() {
        String indent = "        ";
        return indent + "!include c4framework/terminology/definitions.dsl\n";
    }
    
    /**
     * Generates theme references for framework themes.
     */
    private String generateThemeReferences() {
        String indent = "        ";
        StringBuilder themes = new StringBuilder();
        
        themes.append(indent).append("themes ")
              .append("c4framework/themes/c4-framework-default.json ")
              .append("c4framework/themes/c4-framework-colorful.json ")
              .append("c4framework/themes/c4-framework-dark.json\n");
        
        return themes.toString();
    }
    
    /**
     * Gets list of DSL files in a framework subdirectory.
     * 
     * @param subdirectory The subdirectory name (e.g., "persons", "systems")
     * @return List of DSL filenames
     */
    private List<String> getResourceFiles(String subdirectory) {
        try {
            File resourceDir = new File("src/main/resources/c4framework/" + subdirectory);
            if (resourceDir.exists() && resourceDir.isDirectory()) {
                File[] files = resourceDir.listFiles((dir, name) -> name.endsWith(".dsl"));
                if (files != null) {
                    return Arrays.stream(files)
                            .map(File::getName)
                            .sorted()
                            .collect(Collectors.toList());
                }
            }
            
            return getHardcodedResourceFiles(subdirectory);
            
        } catch (Exception e) {
            log.warn("Could not list resource files for " + subdirectory + ": " + e.getMessage());
            return getHardcodedResourceFiles(subdirectory);
        }
    }
    
    /**
     * Returns hardcoded list of framework files for production deployment.
     * This is a fallback when classpath scanning doesn't work.
     */
    private List<String> getHardcodedResourceFiles(String subdirectory) {
        switch (subdirectory) {
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
            case "systems":
                return Arrays.asList(
                    "azure-service-system.dsl",
                    "bounded-context.dsl",
                    "channel-system.dsl",
                    "external-resource-system.dsl",
                    "on-premise-system.dsl"
                );
            case "containers":
                return Arrays.asList(
                    "apigateway-container.dsl",
                    "cosmosdb-container.dsl",
                    "cosmosdb-postgres-container.dsl",
                    "eventhub-container.dsl",
                    "keyvault-container.dsl",
                    "microservice-java-container.dsl",
                    "microservice-node-container.dsl",
                    "mongodb-atlas-container.dsl",
                    "redis-container.dsl",
                    "servicebus-container.dsl"
                );
            case "components":
                return Arrays.asList(
                    "cosmosdb-collection-component.dsl",
                    "cosmosdb-postgres-table-component.dsl",
                    "event-component.dsl",
                    "eventhub-topic-component.dsl",
                    "message-component.dsl",
                    "microservice-restapi-component.dsl",
                    "microservice-soap-component.dsl",
                    "mongodb-atlas-collection-component.dsl",
                    "redis-instance-component.dsl",
                    "servicebus-queue-component.dsl"
                );
            case "styles":
                return Arrays.asList(
                    "element-styles.dsl",
                    "relationship-styles.dsl"
                );
            case "terminology":
                return Arrays.asList(
                    "definitions.dsl"
                );
            case "themes":
                return Arrays.asList(
                    "c4-framework-default.json",
                    "c4-framework-colorful.json",
                    "c4-framework-dark.json"
                );
            default:
                return Arrays.asList();
        }
    }
}
