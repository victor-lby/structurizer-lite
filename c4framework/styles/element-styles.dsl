// Element styles for C4 Framework
// Aligned with arch-as-a-code C4/Structurizr DSL standards
// Source: arch-as-a-code/00-guidelines/templates/modeling/c4/styles/styles.dsl
//
// MANDATORY RULES:
// - Only 8 allowed colors (see colors-palette.yaml)
// - Exactly 19 styles (18 element tags + 1 theme default)
// - Only 6 valid shapes: person, box, roundedbox, hexagon, pipe, cylinder
// - strokeWidth: 2 for persons/externals, 4 for internal containers
// - Text color always #ffffff (white) for contrast
//
// STATUS SEMANTICS:
// - New (Pink #ea3e84): Element created in this iteration
// - Alt (Purple #7030a0): Element modified in this iteration  
// - Same (Gray #9e9e9e): Element unchanged (context)

# element <tag> {
#     shape <Box|RoundedBox|Circle|Ellipse|Hexagon|Cylinder|Pipe|Person|Robot|Folder|WebBrowser|MobileDevicePortrait|MobileDeviceLandscape|Component>
#     icon <file|url>
#     width <integer>
#     height <integer>
#     background <#rrggbb|color name>
#     color <#rrggbb|color name>
#     colour <#rrggbb|color name>
#     stroke <#rrggbb|color name>
#     strokeWidth <integer: 1-10>
#     fontSize <integer>
#     border <solid|dashed|dotted>
#     opacity <integer: 0-100>
#     metadata <true|false>
#     description <true|false>
#     properties {
#         name value
#     }
# }

element "Element" {
    fontSize 1
    metadata false
    description true
}

// ============================================
// PERSON (ACTORS)
// ============================================
element "User" {
    shape person
    background "#7030a0"
    color "#ffffff"
    stroke "#57267b"
    strokeWidth 2
}

// ============================================
// APPLICATIONS (WEB/MOBILE)
// ============================================
element "AppNew" {
    shape roundedbox
    background "#ea3e84"
    color "#ffffff"
    stroke "#c2255c"
    strokeWidth 4
}

element "AppAlt" {
    shape roundedbox
    background "#7030a0"
    color "#ffffff"
    stroke "#57267b"
    strokeWidth 4
}

element "AppSame" {
    shape roundedbox
    background "#9e9e9e"
    color "#ffffff"
    stroke "#6b6b6b"
    strokeWidth 4
}

// ============================================
// MICROSERVICES (BACK-END)
// ============================================
element "SvcNew" {
    shape box
    background "#ea3e84"
    color "#ffffff"
    stroke "#c2255c"
    strokeWidth 4
}

element "SvcAlt" {
    shape box
    background "#7030a0"
    color "#ffffff"
    stroke "#57267b"
    strokeWidth 4
}

element "SvcSame" {
    shape box
    background "#9e9e9e"
    color "#ffffff"
    stroke "#6b6b6b"
    strokeWidth 4
}

// ============================================
// BOUNDED CONTEXT
// ============================================
element "BCNew" {
    shape roundedbox
    background "#ea3e84"
    color "#ffffff"
    stroke "#c2255c"
    strokeWidth 4
}

element "BCAlt" {
    shape roundedbox
    background "#7030a0"
    color "#ffffff"
    stroke "#57267b"
    strokeWidth 4
}

element "BCSame" {
    shape roundedbox
    background "#9e9e9e"
    color "#ffffff"
    stroke "#6b6b6b"
    strokeWidth 4
}

// ============================================
// API GATEWAY
// ============================================
element "GatewayNew" {
    shape hexagon
    background "#ea3e84"
    color "#ffffff"
    stroke "#c2255c"
    strokeWidth 4
}

element "GatewayAlt" {
    shape hexagon
    background "#7030a0"
    color "#ffffff"
    stroke "#57267b"
    strokeWidth 4
}

element "GatewaySame" {
    shape hexagon
    background "#9e9e9e"
    color "#ffffff"
    stroke "#6b6b6b"
    strokeWidth 4
}

// ============================================
// EVENT BROKER
// ============================================
element "EbNew" {
    shape pipe
    background "#ea3e84"
    color "#ffffff"
    stroke "#c2255c"
    strokeWidth 4
}

element "EbAlt" {
    shape pipe
    background "#7030a0"
    color "#ffffff"
    stroke "#57267b"
    strokeWidth 4
}

element "EbSame" {
    shape pipe
    background "#9e9e9e"
    color "#ffffff"
    stroke "#6b6b6b"
    strokeWidth 4
}

// ============================================
// DATABASE
// ============================================
element "DbNew" {
    shape cylinder
    background "#ea3e84"
    color "#ffffff"
    stroke "#c2255c"
    strokeWidth 4
}

element "DbAlt" {
    shape cylinder
    background "#7030a0"
    color "#ffffff"
    stroke "#57267b"
    strokeWidth 4
}

element "DbSame" {
    shape cylinder
    background "#9e9e9e"
    color "#ffffff"
    stroke "#6b6b6b"
    strokeWidth 4
}

// ============================================
// COMPONENT
// ============================================
element "ComponentNew" {
    shape component
    background "#ea3e84"
    color "#ffffff"
    stroke "#c2255c"
    strokeWidth 4
}

element "ComponentAlt" {
    shape component
    background "#7030a0"
    color "#ffffff"
    stroke "#57267b"
    strokeWidth 4
}

element "ComponentSame" {
    shape component
    background "#9e9e9e"
    color "#ffffff"
    stroke "#6b6b6b"
    strokeWidth 4
}

// ============================================
// EXTERNAL SYSTEMS
// ============================================
element "ExtNew" {
    shape box
    background "#ea3e84"
    color "#ffffff"
    stroke "#c2255c"
    strokeWidth 2
}

element "ExtAlt" {
    shape box
    background "#7030a0"
    color "#ffffff"
    stroke "#57267b"
    strokeWidth 2
}

element "ExtSame" {
    shape box
    background "#9e9e9e"
    color "#ffffff"
    stroke "#6b6b6b"
    strokeWidth 2
}