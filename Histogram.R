ui <- fluidPage(
  sliderInput(inputId = "slider", 
              label = "My number", 
              min = 300, 
              max = 19000,
              value = 5000),
  plotOutput("mytext")
)


server <- function(input, output) {
  output$mytext <- 				
    renderPlot({
      hist(rnorm(100, input$slider, 1))
    })
}


shinyApp(ui = ui, server = server)
