# Choices for drop-downs
ui <- div(class = 'navbar1', 
  navbarPage("Yelp Bars Analysis", 
           id = "tabs", 
           theme = "bootstrap.css",
           
           tabPanel("Home", 
                    
                    tags$head(
                      tags$link(href="navbar_style.css", rel="stylesheet", type="text/css")
                    ),
                    
                    tags$div(class = "landing-wrapper",
                             tags$div(class="back", img(src = 'alcohol.jpg')),
                             tags$div(class = "landing-block foreground-content",
                                      tags$div(class = "foreground-text",
                                               tags$h1("Business Analysis of Bars on Yelp"))),
                             tags$div(class = "text1",
                                      tags$div(class = "text", 
                                               tags$h3("Data"),
                                               tags$p("Give some brief introduction of the data."))),
                             tags$div(class = "text2",
                                      tags$div(class = "text", 
                                               tags$h3("Map"),
                                               tags$p("Display the distribution of Bars and related information."))),
                             
                             tags$div(class = "text3",
                                      tags$div(class = "text", 
                                               tags$h3("Exploration"),
                                               tags$p("Show our business analysis report."))),
                             
                             tags$div(class = "text4",
                                      tags$div(class = "text", 
                                               tags$h3("Our suggestions"),
                                               tags$p("Provide with specific suggestions for each Bars.")))
                   )),

           tabPanel("Data",
                    
                    tags$head(
                      tags$link(href="data.css", rel="stylesheet", type="text/css")
                    ),
                    
                    tags$div(class = "landing-wrapper",
                             tags$div(class = "back"),
                             tags$div(class = "landing-block data-title",
                                      tags$div(class = "data-title-content",
                                               tags$h2("Summary of Bars' data"))),
                             tags$div(class = "data-pic1", tags$img(src = 'bar.png', height = 100, width = 100)),
                             tags$div(class = "data-pic2", tags$img(src = 'user.png', height = 100, width = 100)),
                             tags$div(class = "data-pic3", tags$img(src = 'review.png', height = 100, width = 100)),
                             tags$div(class = "data-pic4", tags$img(src = 'tips.png', height = 100, width = 100)),
                             tags$div(class = "data-description1", tags$p("8155 bars businesses")),
                             tags$div(class = "data-description2", tags$p("453,004 users")),
                             tags$div(class = "data-description3", tags$p("946,522 reviews")),
                             tags$div(class = "data-description4", tags$p("170,127 tips")),
                             #tags$div(class = "download-button", 
                             #         downloadButton("down1","Download our data"))
                             tags$div(class = "cleaned-data",
                                      tags$div(class = "title", tags$h2("Categories")),
                                      tags$div(class = "introduction", tags$p("Most businesses in our dataset are restaurant. 
                                                                              In the restaurant category, the 'food' category has 
                                                                              the most number of businesses, then is the 
                                                                              'Nightlife' and the 'bars'.")),
                                      tags$div(class = "pic1", tags$img(src = "business.png", height = 500, width = 350)),
                                      tags$div(class = "pic2", tags$img(src = "Restaurant.png", height = 500, width = 350))
                                      ),
                             tags$div(class = "ratings", 
                                      tags$div(class = "title", tags$h2("Ratings distribution")),
                                      tags$div(class = "introduction", tags$p("The left plot shows the distribution of ratings of all the reviews.
                                                                              Many customers tend to give high ratings.The right plot gives the 
                                                                              distribution of average ratings of all the bars businesses.
                                                                              Most bars receive 3.5 and 4.0 average stars. If your business receives 
                                                                              an average score lower than 3.0, you really need to pay attention.")),
                                      tags$div(class = "pic1", tags$img(src = "ratings1.png", height = 280, width = 440)),
                                      tags$div(class = "pic2", tags$img(src = "ratings2.png", height = 280, width = 440))
                                      ),
                             tags$div(class = "wordcloud",
                                     tags$div(class = "title", tags$h2("Word Cloud")),
                                     tags$div(class = "pic1", tags$img(src = "wordcloud1.png", height = 350, width = 350)),
                                     tags$div(class = "pic2", tags$img(src = "wordcloud2.png", height = 350, width = 350))
                             )
                             )),
              
           tabPanel("Map",
                    div(class = "outer",
                    tags$head(
                    # Include our custom CSS
                          includeCSS("www/style.css"),
                          includeScript("gomap.js")
                    ),
                        
                    leafletOutput("map", width="100%", height="100%"),
                    
                    absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE, draggable = TRUE, 
                                  top = 80, left = "auto", right = 20, bottom = "auto",
                                  width = 300, height = "auto",
                                  h2("Bars on Yelp"),
                                  selectInput("State", h3("State"), 
                                              choices = list("None" = NA, "AB" = "AB",
                                                             "IL" = "IL", "NC" = "NC", 
                                                             "NV" = "NV", "OH" = "OH", 
                                                             "ON" = "ON", "AZ" = "AZ",
                                                             "PA" = "PA", "QC" = "QC",
                                                             "SC" = "SC", "WI" = "WI"
                                                             ), 
                                              selected = NA),
                                  h3("Your Bar's Name"),
                                  textInput.typeahead(id = "search", 
                                                      placeholder = "",
                                                      local=data.frame(name = c(zipdata$key)),
                                                      valueKey = "name",
                                                      tokens=c(1:length(zipdata$key)),
                                                      template = HTML("<p class='repo-name'>{{name}}</p>")
                                  ),
                                  actionButton(inputId = "go", label = "Submit"),
                                  p("Notice: Please check that your input name coincide with which state your bars located")
                    ),
                    tags$div(id="cite",
                      'Data compiled for ', tags$em('Yelp'),"."
                    )
           )
         ),
         navbarMenu("Exploration",
                    tags$head(
                      tags$link(href="Exploration.css", rel="stylesheet", type="text/css")
                    ),
                    
                    tabPanel("TF-IDF",
                             tags$div(class = "landing-wrapper",
                                      tags$div(class = "exploration-back"),
                                      tags$div(class = "TF-IDF", 
                                               tags$div(class = "title", tags$h2("TF-IDF")),
                                               tags$div(class = "introduction", tags$h4("These are some features extracted by TF-IDF method
                                                                       from 'Review' dataset. You can see what will customers
                                                                       will commend on or what they will complain on based on
                                                                       these features.")),
                                               tags$div(class = "result", tags$img(src = "tfidf.png", width = 800, height = 400))
                                      ))),
                    
                   tabPanel("Logistic regression",
                           tags$div(
                             class = "landing-wrapper",
                             tags$div(class = "exploration-back"),
                             tags$div(class = "lm",
                                      tags$div(class = "title", tags$h2("Logistic Regression")),
                                      tags$div(class = "introduction", tags$h4("We use multinomial logistic regression model to analyze
                                                                       attributes to see which attributes are significant. We sepeterate
                                                                       the factors into two groups--those estimated coefficients indicate
                                                                       the factor have negative effects on the ratings while positive coefficients
                                                                       indicate the positive effects on ratings.")),
                                      tags$div(class = "result1", tags$img(src = "neg_attr.png", width = 450, height = 350)),
                                      tags$div(class = "result2", tags$img(src = "pos_attr.png", width = 450, height = 350))
                             ))
                           ),

                  tabPanel("Topic model",
                           tags$div(class = "landing-wrapper", 
                                    tags$div(class = "exploration-back"),
                                    tags$div(class = "score",
                                             tags$div(class = "title", tags$h2("Score model")),
                                             tags$div(class = "state-selection",
                                                      selectInput("State2", 
                                                                  label = em("State",style="text-align:center;color:#FFFFFF;font-size:150%"),
                                                                  choices = list("AB" = "AB",
                                                                                 "IL" = "IL", "NC" = "NC", 
                                                                                 "NV" = "NV", "OH" = "OH", 
                                                                                 "ON" = "ON", "AZ" = "AZ",
                                                                                 "PA" = "PA", "QC" = "QC",
                                                                                 "SC" = "SC", "WI" = "WI"
                                                                  ), 
                                                                  selected = "AB")),
                                             tags$div(class = "topic-selection", 
                                                      uiOutput("ui")
                                                      ),
                                             tags$div(class = "weight-plot", plotOutput("weights"))
                                             )
                                    
                                    )
                             )
         ),
         
         tabPanel("Our suggestions",
                  
                  tags$head(
                    tags$link(href="suggestions.css", rel="stylesheet", type="text/css")
                  ),
                  
                  tags$div(class = "landing-wrapper", 
                           tags$div(class = "exploration-back"),
                           tags$div(class = "suggestions", 
                                    tags$div(class = "title", tags$h2("Suggestions for you")),
                                    tags$div(class = "title2", tags$h3("Put in your bars name:")),
                                    tags$div(class = "Input", 
                                             textInput.typeahead(id = "Input2",
                                                                 placeholder = "",
                                                                 local=data.frame(name = c(zipdata$key)),
                                                                 valueKey = "name",
                                                                 tokens=c(1:length(zipdata$key)),
                                                                 template = HTML("<p class='repo-name'>{{name}}</p>")
                                             ),
                                             actionButton(inputId = "submit", label = "Submit")       
                                    ),
                                    tags$div(class = "out1", htmlOutput("sug_gen")),
                                    tags$div(class = "out2", htmlOutput("sug_spe"))
                           )
                  )
         ),
         
         tabPanel("Contact us",
                  
                  tags$head(
                    tags$link(href="contact_us.css", rel="stylesheet", type="text/css")
                  ),
                  
                  tags$div(class = "landing-wrapper",
                           tags$div(class = "back"),
                           tags$div(class = "landing-block foreground-content",
                                    tags$div(class = "foreground-text",
                                             tags$h2("Our Team"),
                                             tags$h3("Naiqing Cai"),
                                             tags$h3("Jitian Zhao"),
                                             tags$h3("Zihao Li"),
                                             tags$h3("Yaobin Ling")
                                             )),
                           tags$a(class = "icon",tags$img(src = 'twitter.png', height = 30, width = 30), href = "https://twitter.com/UwmYelp"),
                           tags$a(class = "icon2",img(src = 'fb.png', height = 30, width = 30), href = "https://www.facebook.com/yelp.uwm"),
                           tags$a(class = "icon3",img(src = 'linkedin.png', height = 30, width = 30), href = "https://www.linkedin.com/in/yelp-uwm-3bba55195/"),
                           tags$a(class = "icon4",img(src = 'github.png', height = 30, width = 30), href = "https://github.com/zli873/STAT-628-Module3"),
                           tags$div(class = "foot", 
                                    img(src = 'wisc.jpg')
                           )
                  )
         )
)
)

