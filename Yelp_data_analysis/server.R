library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)

zipdata <- zips

function(input, output, session){

# Interactive map ---------------------------------------------------------
    

    # Create the map ----------------------------------------------------------

    
    output$map <- renderLeaflet({
        leaflet() %>%
            addTiles(
                urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
                attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
            ) %>%
            setView(lng = -93.85, lat = 37.45, zoom = 4) # used to initialize the position focus on when open the website
    })
    
    # A reactive expression that returns the set of zips that are
    # in bounds right now
    zipsInBounds <- reactive({
        if (is.null(input$map_bounds))
            return(zipdata[FALSE,])
        bounds <- input$map_bounds
        latRng <- range(bounds$north, bounds$south)
        lngRng <- range(bounds$east, bounds$west)
        
        subset(zipdata,
               latitude >= latRng[1] & latitude <= latRng[2] &
                   longitude >= lngRng[1] & longitude <= lngRng[2])
    })
    

    # Restaurant markers ------------------------------------------------------

    observe({
        leafletProxy("map", data = zips) %>%
            addMarkers(~longitude, ~latitude, layerId=~postal_code)
    })
    

    # Show a popup at the given location --------------------------------------

    showZipcodePopup <- function(zipcode, lat, lon) {
        selectedZip <- zips[zips$postal_code == zipcode,]
        content <- as.character(tagList(
            tags$h3("Restaurant name:", as.character(selectedZip$name)),
            tags$strong(selectedZip$city, selectedZip$state, selectedZip$zipcode),
            tags$br(),
            tags$em("Category:", selectedZip$categories)
        ))
        leafletProxy("map") %>% addPopups(lon, lat, content, layerId = zipcode)
    }
    
    # click: shows the information of restaurant ------------------------------

    observe({
        leafletProxy("map") %>% clearPopups()
        event <- input$map_marker_click
        if (is.null(event))
            return()
        
        isolate({
            showZipcodePopup(event$id, event$lat, event$lng) 
        })
    })
}