library(leaflet)

# Choices for drop-downs


tabPanel("Yelp Restaurant Map",
         div(class = "outer",
             
             tags$head(
                 # Include our custom CSS
                 includeCSS("style.css"),
                 includeScript("gomap.js")
                ),
             
             leafletOutput("map", width="100%", height="100%"),
             
             tags$div(id="cite",
                      'Data compiled for ', tags$em('Yelp'),"."
             )
            ),
         conditionalPanel("false", icon("crosshair"))
        )
