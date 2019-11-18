function(input, output, session){

# Interactive map ---------------------------------------------------------
    zips <- reactive({
        zipdata[zipdata$state == input$State,]
    })
    
    zip_state <- reactive({
        if(input$State == "AB"){
            zipdata_AB
        }else if(input$State == "AZ"){
            zipdata_AZ
        }else if(input$State == "IL"){
            zipdata_IL
        }else if(input$State == "NC"){
            zipdata_NC
        }else if(input$State == "NV"){
            zipdata_NV
        }else if(input$State == "OH"){
            zipdata_OH
        }else if(input$State == "ON"){
            zipdata_ON
        }else if(input$State == "PA"){
            zipdata_PA
        }else if(input$State == "QC"){
            zipdata_QC
        }else if(input$State == "SC"){
            zipdata_SC
        }else if(input$State == "WI"){
            zipdata_WI
        }
    })
           
    weight_state <- reactive({
        if(input$State2 == "AB"){
            AB_weight
        }else if(input$State2 == "AZ"){
            AZ_weight
        }else if(input$State2 == "IL"){
            IL_weight
        }else if(input$State2 == "NC"){
            NC_weight
        }else if(input$State2 == "NV"){
            NV_weight
        }else if(input$State2 == "OH"){
            OH_weight
        }else if(input$State2 == "ON"){
            ON_weight
        }else if(input$State2 == "PA"){
            PA_weight
        }else if(input$State2 == "QC"){
            QC_weight
        }else if(input$State2 == "SC"){
            SC_weight
        }else if(input$State2 == "WI"){
            WI_weight
        }
    })


    # Create the map ----------------------------------------------------------

    output$map <- renderLeaflet({
        leaflet() %>%
            addTiles(
                urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
                attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
            ) %>%
            setView(lng = -93.85, lat = 37.45, zoom = 4) # used to initialize the position focus on when open the website
    })
    
    
    

    # Restaurant markers ------------------------------------------------------

    observe({
        req(input$tabs == "Map")
        leafletProxy("map") %>% clearPopups()
        leafletProxy("map", data = zips()) %>%
            clearMarkers() %>%
            addMarkers(~longitude, ~latitude) %>%
            flyTo(median(as.numeric(zips()$longitude)), median(as.numeric(zips()$latitude)), zoom = 10)
    })
    

 
    # Add textinput ------------------------------------------------------------
    
    search_bar <- eventReactive(input$go, {
        zipdata[zipdata$key == input$search, ]
    })
    
    observe({
        req(input$tabs == "Map")
        leafletProxy("map") %>%
            clearMarkers() %>%
            addMarkers(search_bar()$longitude, search_bar()$latitude) %>%
            flyTo(search_bar()$longitude, search_bar()$latitude, zoom = 15)
    })
    
    

    # Show a popup at the given location --------------------------------------
    
    showZipcodePopup5 <- function(lat, lon, zipstate) {
        selectedZip <- zipstate[(zipstate$latitude == lat) & (zipstate$longitude == lon),]
        content <- as.character(tagList(
            tags$h3(as.character(selectedZip$name)),
            tags$strong(selectedZip$city, selectedZip$state),
            tags$br(),
            tags$em("Stars:", selectedZip$stars),
            tags$br(),
            tags$em("Review count:", selectedZip$review_count),
            tags$br(),
            tags$em("Topic 1: Top", as.integer(selectedZip$topic_1_rank), "%"),
            tags$br(),
            tags$em("Topic 2: Top", as.integer(selectedZip$topic_2_rank), "%"),
            tags$br(),
            tags$em("Topic 3: Top", as.integer(selectedZip$topic_3_rank), "%"),
            tags$br(),
            tags$em("Topic 4: Top", as.integer(selectedZip$topic_4_rank) , "%"),
            tags$br(),
            tags$em("Topic 5: Top", as.integer(selectedZip$topic_5_rank) , "%")
        ))
        leafletProxy("map") %>% addPopups(lon, lat, content)
    }
    
    showZipcodePopup4 <- function(lat, lon, zipstate) {
        selectedZip <- zipstate[(zipstate$latitude == lat) & (zipstate$longitude == lon),]
        content <- as.character(tagList(
            tags$h3(as.character(selectedZip$name)),
            tags$strong(selectedZip$city, selectedZip$state),
            tags$br(),
            tags$em("Stars:", selectedZip$stars),
            tags$br(),
            tags$em("Review count:", selectedZip$review_count),
            tags$br(),
            tags$em("Topic 1: Top", as.integer(selectedZip$topic_1_rank), "%"),
            tags$br(),
            tags$em("Topic 2: Top", as.integer(selectedZip$topic_2_rank), "%"),
            tags$br(),
            tags$em("Topic 3: Top", as.integer(selectedZip$topic_3_rank), "%"),
            tags$br(),
            tags$em("Topic 4: Top", as.integer(selectedZip$topic_4_rank) , "%")
        ))
        leafletProxy("map") %>% addPopups(lon, lat, content)
    }
    
    showZipcodePopup3 <- function(lat, lon, zipstate) {
        selectedZip <- zipstate[(zipstate$latitude == lat) & (zipstate$longitude == lon),]
        content <- as.character(tagList(
            tags$h3(as.character(selectedZip$name)),
            tags$strong(selectedZip$city, selectedZip$state),
            tags$br(),
            tags$em("Stars:", selectedZip$stars),
            tags$br(),
            tags$em("Review count:", selectedZip$review_count),
            tags$br(),
            tags$em("Topic 1: Top", as.integer(selectedZip$topic_1_rank), "%"),
            tags$br(),
            tags$em("Topic 2: Top", as.integer(selectedZip$topic_2_rank), "%"),
            tags$br(),
            tags$em("Topic 3: Top", as.integer(selectedZip$topic_3_rank), "%")
        ))
        leafletProxy("map") %>% addPopups(lon, lat, content)
    }
    
    # click: shows the information of restaurant ------------------------------

    observe({
        leafletProxy("map") %>% clearPopups()
        event <- input$map_marker_click
        if (is.null(event))
            return()
        
        isolate({
            if(input$State == "QC"){
                showZipcodePopup3( event$lat, event$lng, zip_state()) 
            }else if(input$State == "IL" | input$State == "NC" | input$State == "OH" | input$State == "PA" | input$State == "WI"){
                showZipcodePopup4( event$lat, event$lng, zip_state()) 
            }else if(input$State == "AB" | input$State == "AZ" | input$State == "NV" | input$State == "ON" | input$State == "SC"){
                showZipcodePopup5( event$lat, event$lng, zip_state())
            }
            
        })
    })
    

# Exploration -------------------------------------------------------------------
    

    # dynamic ui --------------------------------------------------------------

    
    output$ui <- renderUI({
        if (is.na(input$State2)){
            return() 
        }
        
        switch (input$State2,
            "AB" = radioButtons("topic", 
                                label = em("Topic",style="text-align:center;color:#FFFFFF;font-size:150%"),
                                choiceNames = list(
                                    HTML("<font color='white'>Topics 1</font>"),
                                    HTML("<font color='white'>Topics 2</font>"),
                                    HTML("<font color='white'>Topics 3</font>"),
                                    HTML("<font color='white'>Topics 4</font>"),
                                    HTML("<font color='white'>Topics 5</font>")
                                ),
                                choiceValues = c("Topic 1", "Topic 2",
                                               "Topic 3", "Topic 4","Topic 5"), selected = NULL),
            "AZ" = radioButtons("topic", 
                                label = em("Topic",style="text-align:center;color:#FFFFFF;font-size:150%"),
                                choiceNames = list(
                                    HTML("<font color='white'>Topics 1</font>"),
                                    HTML("<font color='white'>Topics 2</font>"),
                                    HTML("<font color='white'>Topics 3</font>"),
                                    HTML("<font color='white'>Topics 4</font>"),
                                    HTML("<font color='white'>Topics 5</font>")
                                ),
                                choiceValues = c("Topic 1", "Topic 2",
                                                     "Topic 3", "Topic 4","Topic 5"), selected = NULL),
            "IL" = radioButtons("topic", 
                                label = em("Topic",style="text-align:center;color:#FFFFFF;font-size:150%"),
                                choiceNames = list(
                                    HTML("<font color='white'>Topics 1</font>"),
                                    HTML("<font color='white'>Topics 2</font>"),
                                    HTML("<font color='white'>Topics 3</font>"),
                                    HTML("<font color='white'>Topics 4</font>")
                                ),
                                choiceValues = c("Topic 1", "Topic 2",
                                                     "Topic 3", "Topic 4"),
                                                selected = NULL),
            "NC" = radioButtons("topic",
                                label = em("Topic",style="text-align:center;color:#FFFFFF;font-size:150%"),
                                choiceNames = list(
                                    HTML("<font color='white'>Topics 1</font>"),
                                    HTML("<font color='white'>Topics 2</font>"),
                                    HTML("<font color='white'>Topics 3</font>"),
                                    HTML("<font color='white'>Topics 4</font>")
                                ),
                                choiceValues = c("Topic 1", "Topic 2",
                                                     "Topic 3", "Topic 4"), selected = NULL),
            "NV" = radioButtons("topic",
                                label = em("Topic",style="text-align:center;color:#FFFFFF;font-size:150%"),
                                choiceNames = list(
                                    HTML("<font color='white'>Topics 1</font>"),
                                    HTML("<font color='white'>Topics 2</font>"),
                                    HTML("<font color='white'>Topics 3</font>"),
                                    HTML("<font color='white'>Topics 4</font>"),
                                    HTML("<font color='white'>Topics 5</font>")
                                ),
                                choiceValues = c("Topic 1", "Topic 2",
                                                     "Topic 3", "Topic 4","Topic 5"), selected = NULL),
            "OH" = radioButtons("topic",
                                label = em("Topic",style="text-align:center;color:#FFFFFF;font-size:150%"),
                                choiceNames = list(
                                    HTML("<font color='white'>Topics 1</font>"),
                                    HTML("<font color='white'>Topics 2</font>"),
                                    HTML("<font color='white'>Topics 3</font>"),
                                    HTML("<font color='white'>Topics 4</font>")
                                ),
                                choiceValues = c("Topic 1", "Topic 2",
                                                     "Topic 3", "Topic 4"), selected = NULL),
            "ON" = radioButtons("topic", 
                                label = em("Topic",style="text-align:center;color:#FFFFFF;font-size:150%"),
                                choiceNames = list(
                                    HTML("<font color='white'>Topics 1</font>"),
                                    HTML("<font color='white'>Topics 2</font>"),
                                    HTML("<font color='white'>Topics 3</font>"),
                                    HTML("<font color='white'>Topics 4</font>"),
                                    HTML("<font color='white'>Topics 5</font>")
                                ),
                                choiceValues = c("Topic 1", "Topic 2",
                                                     "Topic 3", "Topic 4","Topic 5"), selected = NULL),
            "PA" = radioButtons("topic",
                                label = em("Topic",style="text-align:center;color:#FFFFFF;font-size:150%"),
                                choiceNames = list(
                                    HTML("<font color='white'>Topics 1</font>"),
                                    HTML("<font color='white'>Topics 2</font>"),
                                    HTML("<font color='white'>Topics 3</font>"),
                                    HTML("<font color='white'>Topics 4</font>")
                                ),
                                choiceValues = c("Topic 1", "Topic 2",
                                                     "Topic 3", "Topic 4"), selected = NULL),
            "QC" = radioButtons("topic",
                                label = em("Topic",style="text-align:center;color:#FFFFFF;font-size:150%"),
                                choiceNames = list(
                                    HTML("<font color='white'>Topics 1</font>"),
                                    HTML("<font color='white'>Topics 2</font>"),
                                    HTML("<font color='white'>Topics 3</font>")
                                ),
                                choiceValues = c("Topic 1", "Topic 2","Topic 3"), selected = NULL),
            "SC" = radioButtons("topic",
                                label = em("Topic",style="text-align:center;color:#FFFFFF;font-size:150%"),

                                choiceNames = list(
                                    HTML("<font color='white'>Topics 1</font>"),
                                    HTML("<font color='white'>Topics 2</font>"),
                                    HTML("<font color='white'>Topics 3</font>"),
                                    HTML("<font color='white'>Topics 4</font>"),
                                    HTML("<font color='white'>Topics 5</font>")
                                ),
                                choiceValues = c("Topic 1", "Topic 2",
                                                     "Topic 3", "Topic 4","Topic 5"), selected = NULL),
            "WI" = radioButtons("topic",
                                label = em("Topic",style="text-align:center;color:#FFFFFF;font-size:150%"),
                                choiceNames = list(
                                    HTML("<font color='white'>Topics 1</font>"),
                                    HTML("<font color='white'>Topics 2</font>"),
                                    HTML("<font color='white'>Topics 3</font>"),
                                    HTML("<font color='white'>Topics 4</font>")
                                ),
                                choiceValues = c("Topic 1", "Topic 2",
                                                     "Topic 3", "Topic 4"), selected = NULL)
        )
    })
    

    # Suggestions -------------------------------------------------------------
    sug_bars <- eventReactive(input$submit,{
        a <- zipdata[zipdata$key == input$Input2, ]
        name_a <- as.character(a$name)
        zip_a <- a$postal_code
        if(a$state == "AB"){
            return(zipdata_AB[(zipdata_AB$name == name_a) & (zipdata_AB$postal_code == zip_a), ])
        }else if(a$state == "AZ"){
            return(zipdata_AZ[(zipdata_AZ$name == name_a) & (zipdata_AZ$postal_code == zip_a), ])
        }else if(a$state == "IL"){
            return(zipdata_IL[(zipdata_IL$name == name_a) & (zipdata_IL$postal_code == zip_a), ])
        }else if(a$state == "NC"){
            return(zipdata_NC[(zipdata_NC$name == name_a) & (zipdata_NC$postal_code == zip_a), ])
        }else if(a$state == "NV"){
            return(zipdata_NV[((zipdata_NV$name == name_a) & (zipdata_NV$postal_code == zip_a)), ])
        }else if(a$state == "OH"){
            return(zipdata_OH[((zipdata_OH$name == name_a) & (zipdata_OH$postal_code == zip_a)), ])
        }else if(a$state == "ON"){
            return(zipdata_ON[((zipdata_ON$name == name_a) & (zipdata_ON$postal_code == zip_a)), ])
        }else if(a$state == "PA"){
            return(zipdata_PA[((zipdata_PA$name == name_a) & (zipdata_PA$postal_code == zip_a)), ])
        }else if(a$state == "QC"){
            return(zipdata_QC[((zipdata_QC$name == name_a) & (zipdata_QC$postal_code == zip_a)), ])
        }else if(a$state == "SC"){
            return(zipdata_SC[((zipdata_SC$name == name_a) & (zipdata_SC$postal_code == zip_a)), ])
        }else{
            return(zipdata_WI[((zipdata_WI$name == name_a) & (zipdata_WI$postal_code == zip_a)), ])
        }
            
    })
    
    output$sug_gen <- renderUI({
        strtitle1 <- paste("<font size='6' font color=white>General Suggestions</font>")
        
        str00 <- paste("<font size='4' font color=white>1. Make the target customer more clear and pricing more pointed.</font>")
        str01 <- paste("<font size='4' font color=white>2. Add booths to provide more private room for customers.</font>")
        str02 <- paste("<font size='4' font color=white>3. Increase the diversity of music and make the atmosphere to be more attractive.</font>")
        strtitle01 <- paste("<font size='5' font color=#FFFF33;>Menu</font>")
        strtitle02 <- paste("<font size='5' font color=#FFFF33;>Service</font>")
        strtitle03 <- paste("<font size='5' font color=#FFFF33;>Environment</font>")
        str04 <- paste("<font size='4' font color=white>Provide more craft beer.
                        Add own specialty, such as special drinks.
                        Add more special sauce for wings to improve its taste.
                        Make the target customer more clear and pricing more pointed.
                        The fryer oil needed change regularly.
                        </font>")
        str05 <- paste("<font size='4' font color=white>Improve customer service: such as training the waitress and manager to be politer and service more carefully. Also, hiring more professional bartenders.
                        Speed up customer service.
                        </font>")
        str06 <- paste("<font size='4' font color=white>Add tables to decrease waiting time.
                        Add booths to provide more private room for customers.
                        Increase the diversity of music and make the atmosphere to be more attractive.
                        </font>")
        HTML(paste(strtitle1, str00, str01, str02,  sep = '<br/>'))
    })
    
    output$sug_spe <- eventReactive(input$submit,{
        strtitle2 <- paste("<font size='6' font color=white>Specific Suggestions</font>")
        if (sug_bars()$state == "ON"){
            if (sug_bars()$topic_1_rank > 50){
                str11 <- paste("<font size='5' font color=#FFFF33;>Table Availablity:</font> <font size='4' font color='white' >Add tables to decrease waiting time.
                               Provide some entertainment and seats for waiting customers.Increase table turnover rate.</font>")
            }else{str11 <- paste("")}
            if (sug_bars()$topic_2_rank > 50){
                str12 <- paste("<font size='5' font color=#FFFF33;>Food Flavor:</font> <font size='4' font color='white'>The fryer oil needed change regularly. Add more special sauce for wings to improve its taste. Add own specialty, such as special 
                               drinks. Make fresher food.</font>")
            }else{str12 <- paste("")}
            if (sug_bars()$topic_3_rank > 50){
                str13 <- paste("<font size='5' font color=#FFFF33;>Bartender Proficiency:</font> <font size='4' font color='white'>Hiring more professional bartenders. Provide more craft beer.</font>")
            }else{str13 <- paste("")}
            if (sug_bars()$topic_4_rank > 50){
                str14 <- paste("<font size='5' font color=#FFFF33;>Service and Order Time:</font> <font size='4' font color='white'>Hire more staff to speed up service. Offer some gifts or discounts for customers who wait too long.</font>")
            }else{str14 <- paste("")}
            if (sug_bars()$topic_5_rank > 50){
                str15 <- paste("<font size='5' font color=#FFFF33;>Service Etiquette:</font> <font size='4' font color='white'>Improve customer service: such as training the waitress and manager to be politer and serve more carefully. Pay more attention to customers feedback.</font>")
            }else{str15 <- paste("")}
            HTML(paste(strtitle2, str11, str12, str13, str14, str15, sep = '<br/>'))
        }else if (sug_bars()$state == "AZ"){
            if (sug_bars()$topic_1_rank > 50){
                str11 <- paste("<font size='5' font color=#FFFF33;>Table Availablity:</font> <font size='4' font color='white'>Add tables to decrease waiting time.Provide some entertainment and seats for waiting customers.Increase table turnover rate.</font>")
            }else{str11 <- paste("")}
            if (sug_bars()$topic_2_rank > 50){
                str12 <- paste("<font size='5' font color=#FFFF33;>Food Flavor:</font> <font size='4' font color='white'>The fryer oil needed change regularly. Add more special sauce for wings to improve its taste. Add own specialty, such as special 
                               drinks. Make fresher food.</font>")
            }else{str12 <- paste("")}
            if (sug_bars()$topic_3_rank > 50){
                str13 <- paste("<font size='5' font color=#FFFF33;>Bartender Proficiency:</font> <font size='4' font color='white'>Hiring more professional bartenders. Provide more craft beer.</font>")
            }else{str13 <- paste("")}
            if (sug_bars()$topic_4_rank > 50){
                str14 <- paste("<font size='5' font color=#FFFF33;>Service and Order Time:</font> <font size='4' font color='white'>Hire more staff to speed up service. Offer some gifts or discounts for customers who wait too long.</font>")
            }else{str14 <- paste("")}
            if (sug_bars()$topic_5_rank > 50){
                str15 <- paste("<font size='5' font color=#FFFF33;>Service Etiquette:</font> <font size='4' font color='white'>Improve customer service: such as training the waitress and manager to be politer and serve more carefully. Pay more attention to customers feedback.</font>")
            }else{str15 <- paste("")}
            HTML(paste(strtitle2, str11, str12, str13, str14, str15, sep = '<br/>'))
        }else if(sug_bars()$state == "IL"){
            if (sug_bars()$topic_1_rank > 50){
                str11 <- paste("<font size='5' font color=#FFFF33;>Service and Order Time:</font> <font size='4' font color='white'>Hire more staff to speed up service.Offer some gifts or discounts for customers who wait too long.Improve customer service: 
                               such as training the waitress and manager to be politer and serve more carefully.Pay more attention to customers’ feedback.</font>")
            }else{str11 <- paste("")}
            if (sug_bars()$topic_2_rank > 50){
                str12 <- paste("<font size='5' font color=#FFFF33;>Food Flavor</font> <font size='4' font color='white'>Add more special sauce for wings to improve its taste.Add own specialty, such as special drinks.Make fresher food.Control the steak to be cooked well.</font>")
            }else{str12 <- paste("")}
            if (sug_bars()$topic_3_rank > 50){
                str13 <- paste("<font size='5' font color=#FFFF33;>Bartender Proficiency:</font> <font size='4' font color='white'>Hiring more professional bartenders. Provide more craft beer.</font>")
            }else{str13 <- paste("")}
            if (sug_bars()$topic_4_rank > 50){
                str14 <- paste("<font size='5' font color=#FFFF33;>Table Avalability:</font> <font size='4' font color='white'>Add tables to decrease waiting time.Increase table turnover rate.Provide some entertainment and seats for waiting customers.</font>")
            }else{str14 <- paste("")}
            HTML(paste(strtitle2, str11, str12, str13, str14, sep = '<br/>'))
        }else if(sug_bars()$state == "NC"){
            if (sug_bars()$topic_1_rank > 50){
                str11 <- paste("<font size='5' font color=#FFFF33;>Table Avalability:</font> <font size='4' font color='white'>Add tables to decrease waiting time.Increase table turnover rate.Provide some entertainment and seats for waiting customers.</font>")
            }else{str11 <- paste("")}
            if (sug_bars()$topic_2_rank > 50){
                str12 <- paste("<font size='5' font color=#FFFF33;>Food Flavor</font> <font color='white'>The fryer oil needed change regularly.Add more special sauce for wings to improve its taste.Add own specialty, such as special drinks.Make fresher food.</font>")
            }else{str12 <- paste("")}
            if (sug_bars()$topic_3_rank > 50){
                str13 <- paste("<font size='5' font color=#FFFF33;>Bartender Proficiency:</font> <font size='4' font color='white'>Hiring more professional bartenders. Provide more craft beer.</font>")
            }else{str13 <- paste("")}
            if (sug_bars()$topic_4_rank > 50){
                str14 <- paste("<font size='5' font color=#FFFF33;>Service and Order Time:</font> <font size='4' font color='white'>Hire more staff to speed up service.Offer some gifts or discounts for customers who wait too long.Improve customer service: such as training the waitress and manager to be politer and serve more carefully.Pay more attention to customers’ feedback.</font>")
            }else{str14 <- paste("")}
            HTML(paste(strtitle2, str11, str12, str13, str14, sep = '<br/>'))
        }else if(sug_bars()$state == "NV"){
            if (sug_bars()$topic_1_rank > 50){
                str11 <- paste("<font size='5' font color=#FFFF33;>Table Avalability:</font> <font size='4' font color='white'>Add tables to decrease waiting time.Increase table turnover rate.Provide some entertainment and seats for waiting customers.</font>")
            }else{str11 <- paste("")}
            if (sug_bars()$topic_2_rank > 50){
                str12 <- paste("<font size='5' font color=#FFFF33;>Customer Care:</font> <font size='4' font color='white'>The fryer oil needed change regularly.Add more special sauce for wings to improve its taste.Add own specialty, such as special drinks.Make fresher food.</font>")
            }else{str12 <- paste("")}
            if (sug_bars()$topic_3_rank > 50){
                str13 <- paste("<font size='5' font color=#FFFF33;>Bartender Proficiency:</font> <font size='4' font color='white'>Hiring more professional bartenders. Provide more craft beer.</font>")
            }else{str13 <- paste("")}
            if (sug_bars()$topic_4_rank > 50){
                str14 <- paste("<font size='5' font color=#FFFF33;>Food Flavor:</font><font size='4' font color='white'>Hire more staff to speed up service.
                                Offer some gifts or discounts for customers who wait too long.
                                Improve customer service: such as training the waitress and manager to be politer and serve more carefully.
                                Pay more attention to customers’ feedback.
                                </font>")
            }else{str14 <- paste("")}
            if (sug_bars()$topic_5_rank > 50){
                str15 <- paste("<font size='5' font color=#FFFF33;>Shows:</font><font size='4' font color='white'>Add more shows in club at night</font>")
            }else{str15 <- paste("")}
            HTML(paste(strtitle2, str11, str12, str13, str14, str15, sep = '<br/>'))
        }else if(sug_bars()$state == "OH"){
            if (sug_bars()$topic_1_rank > 50){
                str11 <- paste("<font size='5' font color=#FFFF33;>Table Avalability:</font> <font size='4' font color='white'>Add tables to decrease waiting time.Increase table turnover rate.Provide some entertainment and seats for waiting customers.</font>")
            }else{str11 <- paste("")}
            if (sug_bars()$topic_2_rank > 50){
                str12 <- paste("<font size='5' font color=#FFFF33;>Food Flavor:</font> <font size='4' font color='white'>Make customer feel like at home because most of them are tourists.</font>")
            }else{str12 <- paste("")}
            if (sug_bars()$topic_3_rank > 50){
                str13 <- paste("<font size='5' font color=#FFFF33;>Bartender Proficiency:</font> <font size='4' font color='white'>Hiring more professional bartenders. Provide more craft beer.</font>")
            }else{str13 <- paste("")}
            if (sug_bars()$topic_4_rank > 50){
                str14 <- paste("<font size='5' font color=#FFFF33;>Service and Order Time:</font> <font size='4' font color='white'>Hire more staff to speed up service.
                                Offer some gifts or discounts for customers who wait too long.
                                Improve customer service: such as training the waitress and manager to be politer and serve more carefully.
                                Pay more attention to customers’ feedback.
                                </font>")
            }else{str14 <- paste("")}
            HTML(paste(strtitle2, str11, str12, str13, str14, sep = '<br/>'))
        }else if(sug_bars()$state == "AB"){
            if (sug_bars()$topic_1_rank > 50){
                str11 <- paste("<font size='5' font color=#FFFF33;>Table Avalability:</font> <font size='4' font color='white'>Add tables to decrease waiting time.Increase table turnover rate.Provide some entertainment and seats for waiting customers.</font>")
            }else{str11 <- paste("")}
            if (sug_bars()$topic_2_rank > 50){
                str12 <- paste("<font size='5' font color=#FFFF33;>Food Freshness:</font> <font size='4' font color='white'>The fryer oil needed change regularly.Add own specialty, such as special drinks.Make fresher food.Control the steak to be cooked well.</font>")
            }else{str12 <- paste("")}
            if (sug_bars()$topic_3_rank > 50){
                str13 <- paste("<font size='5' font color=#FFFF33;>Food Flavor:</font> <font size='4' font color='white'>Add more special sauce for wings to improve its taste.</font>")
            }else{str13 <- paste("")}
            if (sug_bars()$topic_4_rank > 50){
                str14 <- paste("<font size='5' font color=#FFFF33;>Drinks and Environment:</font> <font size='4' font color='white'>Increase the diversity of music and make the atmosphere to be more attractive.Control the music volume.Provide more craft beer.</font>")
            }else{str14 <- paste("")}
            if (sug_bars()$topic_5_rank > 50){
                str15 <- paste("<font size='5' font color=#FFFF33;>Service and Order Time:</font> <font size='4' font color='white'>Hire more staff to speed up service.Offer some gifts or discounts for customers who wait too long.Improve customer service: such as training the 
                               waitress and manager to be politer and serve more carefully.Pay more attention to customers’ feedback.</font>")
            }else{str15 <- paste("")}
            HTML(paste( strtitle2, str11, str12, str13, str14, str15, sep = '<br/>'))
        }else if(sug_bars()$state == "PA"){
            if (sug_bars()$topic_1_rank > 50){
                str11 <- paste("<font size='5' font color=#FFFF33;>Table Availability:</font> <font size='4' font color='white'>Add tables to decrease waiting time.Increase table turnover rate.Provide some entertainment and seats for waiting customers.</font>")
            }else{str11 <- paste("")}
            if (sug_bars()$topic_2_rank > 50){
                str12 <- paste("<font size='5' font color=#FFFF33;>Food Flavor:</font> <font size='4' font color='white'>Make customer feel like at home because most of them are tourists.</font>")
            }else{str12 <- paste("")}
            if (sug_bars()$topic_3_rank > 50){
                str13 <- paste("<font size='5' font color=#FFFF33;>Bartender Proficiency:</font> <font size='4' font color='white'>Hiring more professional bartenders. Provide more craft beer.</font>")
            }else{str13 <- paste("")}
            if (sug_bars()$topic_4_rank > 50){
                str14 <- paste("<font size='5' font color=#FFFF33;>Service and Order Time:</font> <font size='4' font color='white'>The fryer oil needed change regularly.Add more special sauce for wings to improve its taste.
                                Add own specialty, such as special drinks.Make fresher food.</font>")
            }else{str14 <- paste("")}
            HTML(paste(strtitle2, str11, str12, str13, str14, sep = '<br/>'))
        }else if(sug_bars()$state == "QC"){
            if (sug_bars()$topic_1_rank > 50){
                str11 <- paste("<font size='5' font color=#FFFF33;>Table Availability:</font> <font size='4' font color='white'>Add tables to decrease waiting time.Increase table turnover rate.Provide some entertainment and seats for waiting customers.</font>")
            }else{str11 <- paste("")}
            if (sug_bars()$topic_2_rank > 50){
                str12 <- paste("<font size='5' font color=#FFFF33;>Bartender Proficiency:</font> <font size='4' font color='white'>Hiring more professional bartenders. Provide more craft beer.</font>")
            }else{str12 <- paste("")}
            if (sug_bars()$topic_3_rank > 50){
                str13 <- paste("<font size='5' font color=#FFFF33;>Food Flavor:</font> <font size='4' font color='white'>The fryer oil needed change regularly.Add own specialty,
                               such as special drinks.Make fresher food.Add more special sauce for wings to improve its taste.</font>")
            }else{str13 <- paste("")}
            HTML(paste(strtitle2, str11, str12, str13, sep = '<br/>'))
        }else if(sug_bars()$state == "SC"){
            if (sug_bars()$topic_1_rank > 50){
                str11 <- paste("<font size='5' font color=#FFFF33;>Table Availability:</font> <font size='4' font color='white'>Add tables to decrease waiting time.Increase table turnover rate.Make the table cleaner.</font>")
            }else{str11 <- paste("")}
            if (sug_bars()$topic_2_rank > 50){
                str12 <- paste("<font size='5' font color=#FFFF33;>Burger:</font> <font size='4' font color='white'>Control the quality of burger.</font>")
            }else{str12 <- paste("")}
            if (sug_bars()$topic_3_rank > 50){
                str13 <- paste("<font size='5' font color=#FFFF33;>Bartender Proficiency:</font> <font size='4' font color='white'>Hiring more professional bartenders.</font>")
            }else{str13 <- paste("")}
            if (sug_bars()$topic_4_rank > 50){
                str14 <- paste("<font size='5' font color=#FFFF33;>Service Quality:</font> <font size='4' font color='white'>Hire more staff to speed up service.Offer some gifts or discounts for customers who wait too long.Improve customer service:
                               such as training the waitress and manager to be politer and serve more carefully.Pay more attention to customers’ feedback.</font>")
            }else{str14 <- paste("")}
            if (sug_bars()$topic_5_rank > 50){
                str15 <- paste("<font size='5' font color=#FFFF33;>Food Flavor:</font> <font size='4' font color='white'>The fryer oil needed change regularly.Add own specialty, such as special drinks.Make fresher food.Add more special sauce for wings to improve its taste.</font>")
            }
            HTML(paste(strtitle2, str11, str12, str13, str14, str15, sep = '<br/>'))
        }else if(sug_bars()$state == "WI"){
            if (sug_bars()$topic_1_rank > 50){
                str11 <- paste("<font size='5' font color=#FFFF33;>Table Availability:</font> <font size='4' font color='white'>Add tables to decrease waiting time.Increase table turnover rate.Provide some entertainment and seats for waiting customers.</font>")
            }else{str11 <- paste("")}
            if (sug_bars()$topic_2_rank > 50){
                str12 <- paste("<font size='5' font color=#FFFF33;>Food Flavor:</font> <font size='4' font color='white'>The fryer oil needed change regularly.Add own specialty, such as special drinks.Make fresher food.Add more special sauce for wings to improve its taste.</font>")
            }else{str12 <- paste("")}
            if (sug_bars()$topic_3_rank > 50){
                str13 <- paste("<font size='5' font color=#FFFF33;>Bartender Proficiency:</font> <font size='4' font color='white'>Hiring more professional bartenders. Provide more craft beer.</font>")
            }else{str13 <- paste("")}
            if (sug_bars()$topic_4_rank > 50){
                str14 <- paste("<font size='5' font color=#FFFF33;>Service Quality:</font> <font size='4' font color='white'>Hire more staff to speed up service.Offer some gifts or discounts for customers who wait too long.Improve customer service: such as training the waitress and manager 
                               to be politer and serve more carefully.Pay more attention to customers’ feedback.</font>")
            }else{str14 <- paste("")}
            HTML(paste(strtitle2, str11, str12, str13, str14, sep = '<br/>'))
        }
        
    })

    # Plot --------------------------------------------------------------------
    observe({
        event <- input$topic
        if(is.null(event)){
            return()
        }
        output$weights <- renderPlot({
                if(input$topic == "Topic 1"){
                    ggplot(data = weight_state(), aes(x = topic_1words, y = topic_1weight)) + geom_bar(stat = "identity", color = "steelblue", fill = "steelblue", width = 0.5) + 
                        theme(panel.background = element_rect(fill = 'black', colour = "white"),
                              axis.text.x = element_text(size = 18, color = "white"),
                              axis.text.y = element_text(size = 18, color = "white"),
                              axis.title.y = element_text(size=22, color = "white"),
                              axis.title.x = element_text(size=22, color = "white"),
                              plot.background = element_rect(colour = "black",fill = "black")) + 
                        xlab('Words') + ylab('Weights') + scale_fill_manual(values = "#56B4E9")
                }else if(input$topic == "Topic 2"){
                    ggplot(data = weight_state(), aes(x = topic_2words, y = topic_2weight)) + geom_bar(stat = "identity",color = "steelblue", fill = "steelblue", width = 0.5) + 
                        theme(panel.background = element_rect(fill = 'black', colour = "white"),
                              axis.text.x = element_text(size = 18, color = "white"),
                              axis.text.y = element_text(size = 18, color = "white"),
                              axis.title.y = element_text(size=22, color = "white"),
                              axis.title.x = element_text(size=22, color = "white"),
                              plot.background = element_rect(colour = "black",fill = "black")) + 
                        xlab('Words') + ylab('Weights') + scale_fill_manual(values = "#56B4E9")
                }else if(input$topic == "Topic 3"){
                    ggplot(data = weight_state(), aes(x = topic_3words, y = topic_3weight)) + geom_bar(stat = "identity", color = "steelblue", fill = "steelblue", width = 0.5) + 
                        theme(panel.background = element_rect(fill = 'black', colour = "white"),
                              axis.text.x = element_text(size = 18, color = "white"),
                              axis.text.y = element_text(size = 18, color = "white"),
                              axis.title.y = element_text(size=22, color = "white"),
                              axis.title.x = element_text(size=22, color = "white"),
                              plot.background = element_rect(colour = "black",fill = "black")) + 
                        xlab('Words') + ylab('Weights') + scale_fill_manual(values = "#56B4E9")
                }else if(input$topic == "Topic 4"){
                    ggplot(data = weight_state(), aes(x = topic_4words, y = topic_4weight)) + geom_bar(stat = "identity", color = "steelblue", fill = "steelblue", width = 0.5) + 
                        theme(panel.background = element_rect(fill = 'black', colour = "white"),
                              axis.text.x = element_text(size = 18, color = "white"),
                              axis.text.y = element_text(size = 18, color = "white"),
                              axis.title.y = element_text(size=22, color = "white"),
                              axis.title.x = element_text(size=22, color = "white"),
                              plot.background = element_rect(colour = "black",fill = "black")) + 
                        xlab('Words') + ylab('Weights') + scale_fill_manual(values = "#56B4E9")
                }else if(input$topic == "Topic 5"){
                    ggplot(data = weight_state(), aes(x = topic_5words, y = topic_5weight)) + geom_bar(stat = "identity", color = "steelblue", fill = "steelblue", width = 0.5) + 
                        theme(panel.background = element_rect(fill = 'black', colour = "white"),
                              axis.text.x = element_text(size = 18, color = "white"),
                              axis.text.y = element_text(size = 18, color = "white"),
                              axis.title.y = element_text(size=22, color = "white"),
                              axis.title.x = element_text(size=22, color = "white"),
                              plot.background = element_rect(colour = "black",fill = "black")) + 
                        xlab('Words') + ylab('Weights') + scale_fill_manual(values = "#56B4E9")}
        },
        height = 500, width = 700)
    })
}