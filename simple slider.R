ui <- fluidPage(
	sliderInput(inputId = "slider", 
			label = "My number", 
			min = 300, 
			max = 19000,
			value = 350),
	textOutput("mytext")
)

server <- function(input, output) {
	output$mytext <- renderText({input$slider})
}

shinyApp(ui = ui, server = server)
