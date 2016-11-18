library(ggplot2) # or declared in server.R

ui <- fluidPage(
	sliderInput(inputId = "mean",  label = "mean", 
			min = 300, max = 19000, value = 5000),
	sliderInput(inputId = "sd",  label = "standard deviation", 
			min = 50, max = 1000, value = 500),
	plotOutput("histogram")
)

server <- function(input, output) {
	output$histogram <- 				
		renderPlot({
			my_df <- as.data.frame(rnorm(100, input$mean, input$sd))
			colnames(my_df) <- 'rnum'
			ggplot(data = my_df, aes(x = rnum)) + geom_histogram()})
}

shinyApp(ui = ui, server = server)
