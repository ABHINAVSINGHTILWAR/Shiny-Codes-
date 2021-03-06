ui <- fluidPage(
	sliderInput(inputId = "mean",  label = "mean", 
					min = 300, max = 19000, value = 5000),
	sliderInput(inputId = "sd",  label = "standard deviation", 
					min = 50, max = 1000, value = 500),
	plotOutput("histogram")
)

server <- function(input, output) {
	output$histogram <- 				
		renderPlot({hist(rnorm(100, input$mean, input$sd))})
}

shinyApp(ui = ui, server = server)
