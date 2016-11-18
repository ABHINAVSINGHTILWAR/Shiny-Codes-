library(shiny)
ui <- fluidPage(
  titlePanel(h1("Shiny Homework:Movies")),
  sidebarLayout(
    sidebarPanel(h4("Select the subset of records to retrieve by making selections below",style = "color: blue"),
                 radioButtons("ui.director", label = strong("Director"), choices = list("Spielberg" = "Spielberg", 
                                                                                        "Jackson" = "Jackson",
                                                                                        "Cameron" = "Cameron",
                                                                                        "Bay" = "Bay",
                                                                                        "Nolan" = "Nolan",
                                                                                        "Yates" = "Yates",
                                                                                        "Zemeckis" = "Zemeckis",
                                                                                        "Verbinski" = "Verbinski",
                                                                                        "Columbus" = "Columbus",
                                                                                        "Burton" = "Burton"),selected = "Burton"),
                 br(),
                 numericInput("ui.budget", label = strong("Minimum Budget"), value = 0)
                 ),
    mainPanel(h4("Movie Revenue and Budget",style = "color: green"),
              plotOutput("movies.plot"),
              dataTableOutput('movies.table')
    )
  )
)
library(ggplot2)
movies.df <- read.csv('movies.csv')

server <- function(input, output) {
  output$movies.plot <- renderPlot({ 
    qplot(revenue, budget, data = movies.df[movies.df$director == input$ui.director & movies.df$budget > input$ui.budget,])
  })
  output$movies.table <- renderDataTable(movies.df)
}

shinyApp(ui = ui, server = server)