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
    background "#9e9e9e"
    color "#ffffff"
    stroke "#6b6b6b"
    strokeWidth 4
}

element "Database" {
    shape Cylinder
}

element "Cache" {
    shape Folder
}

element "Topic" {
    shape Pipe
}

element "Queue" {
    shape Pipe
}

element "API" {
    shape Component
}

element "Microservice" {
    shape Hexagon
}

element "Scheduled" {
    icon "https://img.icons8.com/fluency-systems-filled/48/stopwatch.png"
}

element "New" {
    background "#ea3e84"
    color "#ffffff"
    stroke "#c2255c"
    strokeWidth 4
}

element "Changed" {
    background "#7030a0"
    color "#ffffff"
    stroke "#57267b"
    strokeWidth 4
}

element "Unchanged" {
    background "#9e9e9e"
    color "#ffffff"
    stroke "#6b6b6b"
    strokeWidth 4
}