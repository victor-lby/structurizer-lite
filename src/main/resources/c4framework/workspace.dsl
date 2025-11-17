workspace "C4 Framework" "A comprehensive C4 modeling framework with reusable archetypes for containers, components, and infrastructure" {
    !identifiers hierarchical
    
    model {
        // Archetypes - Reusable patterns for teams
        archetypes {
            
            // Person Archetypes - Role-based personas
            !include "./persons/consultor-person.dsl"
            !include "./persons/agente-externo-person.dsl"
            !include "./persons/arquiteto-person.dsl"
            !include "./persons/cliente-person.dsl"
            !include "./persons/desenvolvedor-person.dsl"
            !include "./persons/diretor-person.dsl"
            !include "./persons/gerente-loja-person.dsl"
            !include "./persons/gerente-regional-person.dsl"
            !include "./persons/gerente-territorial-person.dsl"
            
            // System Patterns - Deployment and technology patterns
            !include "./systems/channel-system.dsl"
            !include "./systems/external-resource-system.dsl"
            !include "./systems/on-premise-system.dsl"
            !include "./systems/function.dsl"

            // Groups - Reusable groups for teams
            # !include "./groups/bounded-context.dsl"
            # !include "./groups/domain.dsl"
            # !include "./groups/subdomain.dsl"
            # !include "./groups/layer.dsl"

            // Container Archetypes - Core container patterns
            !include "./containers/apigateway-container.dsl"
            !include "./containers/cosmosdb-container.dsl"
            !include "./containers/cosmosdb-postgres-container.dsl"
            !include "./containers/eventhub-container.dsl"
            !include "./containers/keyvault-container.dsl"
            !include "./containers/microservice-java-container.dsl"
            !include "./containers/microservice-node-container.dsl"
            !include "./containers/mongodb-atlas-container.dsl"
            !include "./containers/redis-container.dsl"
            !include "./containers/servicebus-container.dsl"
            

            // Component Archetypes - Core component patterns
            !include "./components/cosmosdb-collection-component.dsl"
            !include "./components/cosmosdb-postgres-table-component.dsl"
            !include "./components/event-component.dsl"
            !include "./components/eventhub-topic-component.dsl"
            !include "./components/message-component.dsl"
            !include "./components/microservice-restapi-component.dsl"
            !include "./components/microservice-soap-component.dsl"
            !include "./components/mongodb-atlas-collection-component.dsl"
            !include "./components/redis-instance-component.dsl"
            !include "./components/servicebus-queue-component.dsl"
        }
            
    }
    
    views {
        styles {
            !include "./styles/element-styles.dsl"
            !include "./styles/relationship-styles.dsl"
            
            theme default
        }

        !include "./terminology/definitions.dsl"

        themes "./themes/c4-framework-colorful.json" "./themes/c4-framework-dark.json" "./themes/c4-framework-default.json"
        
        branding {
            logo "https://grandesnomesdapropaganda.com.br/wp-content/uploads/2018/02/Telef%C3%B4nica-Brasil.jpg"
        }
    }
}