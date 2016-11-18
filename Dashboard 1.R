ui <- fluidPage(
    titlePanel("My Diamond Visualization"),
    sidebarLayout(
	sidebarPanel("Diamond Attributes",
	sliderInput("ui.price", label = "Price", min=300, max=19000, value=c(4000,5000)),
	sliderInput("ui.weight", label = "Weight", min = 0.1, max = 5.5, value = c(1.1,3.3), step= 0.1),
	checkboxGroupInput("ui.cut", label = "Cut", choices = list("Ideal" = "Ideal", "Premium" = "Premium", "Very Good" = "Very Good", "Good" = "Good", "Fair" = "Fair", "Poor" = "Poor"), selected = "Ideal"),
	selectInput("ui.clarity", label = "Clarity", choices = list("Flawless" = "FL", "Internally Flawless" = "IF", "Very Very Slightly Included" = "VVS1,VVS2", "Very Slightly Included" = "VS1,VS2", "Slightly Included" = 		"S1,S2", "Included" = "I1,I2,I3")),
	radioButtons("ui.graph", label = "Graph", choices = list("Scatterplot" = "Scatterplot", "Density" = "Density"))
	),
    mainPanel("Diamond Results",
	plotOutput("diamond.plot")
	)
   )
)

server <- function(input, output) {	
	library(ggplot2)
	my.diamonds <- diamonds[sample(nrow(diamonds), 1000),]
	filterDataRenderPlot <- reactive({
		if (input$ui.clarity == "FL") {my.diamonds <- my.diamonds[my.diamonds$clarity == "FL",]}
		else if (input$ui.clarity == "IF") {my.diamonds <- my.diamonds[my.diamonds$clarity == "IF",]}
		else if (input$ui.clarity == "VVS1,VVS2") {my.diamonds <- my.diamonds[my.diamonds$clarity == "VVS1" | my.diamonds$clarity == "VVS2",]}
		else if (input$ui.clarity == "VS1,VS2") {my.diamonds <- my.diamonds[my.diamonds$clarity == "VS1" | my.diamonds$clarity == "VS2",]}
		else if (input$ui.clarity == "S1,S2") {my.diamonds <- my.diamonds[my.diamonds$clarity == "S1" | my.diamonds$clarity == "S2",]}
		else if (input$ui.clarity == "I1,I2,I3") {my.diamonds <- my.diamonds[my.diamonds$clarity == "I1" | my.diamonds$clarity == "I2" | my.diamonds$clarity == "I3",]}
		filtered.diamonds <- subset(my.diamonds, cut %in% input$ui.cut 	& carat > input$ui.weight[1] & carat < input$ui.weight[2]  & price > input$ui.price[1] & price < input$ui.price[2])
	})
	output$diamond.plot <- renderPlot({ 
		if (input$ui.graph == "Scatterplot") {qplot(carat, price, color = color, data = filterDataRenderPlot()) + xlim(.1, 5.6) + ylim(300, 19000) }
		else if (input$ui.graph == "Density") {qplot(price, fill = color, geom = "density", alpha=I(.3), data = filterDataRenderPlot()) + xlim(300, 19000) }
	})
}

shinyApp(ui = ui, server = server)
