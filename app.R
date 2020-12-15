## app.R ##
library(shiny)
library(shinydashboard)
library(DT)

ui <- dashboardPage(skin = "purple",
    dashboardHeader(title = "My First Analytics Dashboard"),
    dashboardSidebar(sidebarMenu(
            menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
            menuItem("Widgets", tabName = "widgets", icon = icon("th")),
            menuItem("Analytics", tabName = "analytics", icon = icon("atom")),
            menuItem("Data Table", tabName = "table", icon = icon("table"))
        )
    ),
    dashboardBody(# Boxes need to be put in a row (or column)
        tabItems(
            # First tab content
            tabItem(tabName = "dashboard",
                    fluidRow(
                        box(plotOutput("plot1", height = 250)),
                        
                        box(
                            title = "Controls",
                            sliderInput("slider0", "Number of observations:", 1, 100, 50)
                        )
                    )
            ),
            
            # Second tab content
            tabItem(tabName = "widgets",
                    h2("Widgets tab content")
            ),
            
            # Third tab content
            tabItem(tabName = "analytics",
                    h2("Analytics tab content"),
                    fluidRow(
                        box(plotOutput("plot2", height = 250)),
                        
                        box(
                            title = "Controls",
                            sliderInput("slider", "Number of observations:", 1, 100, 50)
                        )
                    ),
                    fluidRow(
                        box(
                            # Copy the chunk below to make a group of checkboxes
                            checkboxGroupInput("checkGroup", label = h3("My First Checkbox group"), 
                                               choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
                                               selected = 1),
                            width =5
                        ),
                        
                        box(
                            verbatimTextOutput("value"), width =7
                        )
                    ),
                    fluidRow(
                        # A static infoBox
                        infoBox("The first", 10 * 2, icon = icon("credit-card"), width =3),
                        infoBox("The second", 10 * 2, icon = icon("credit-card"), width =6),
                        infoBox("The third", 10 * 2, icon = icon("credit-card"), width =3),
                    ),
            ),
            # Fourth tab content
            tabItem(tabName = "table",
                    h2("Air BnB Data Table")
            )
        )
    )
)

server <- function(input, output) {
    #get dataset
    airBnbListings <- read.csv("listings.csv")
    set.seed(122)
    histdata <- rnorm(500)    
    output$plot1 <- renderPlot({
        data <- histdata[seq_len(input$slider)]
        hist(data)
    })
    output$plot2 <- renderPlot({
        data <- histdata[seq_len(input$slider)]
        hist(data)
    })
    output$plot3 <- renderPlot({
        data <- histdata[seq_len(input$slider)]
        hist(data)
    })
    # You can access the values of the widget (as a vector)
    # with input$checkGroup, e.g.
    output$value <- renderPrint({ input$checkGroup })
}

shinyApp(ui, server)