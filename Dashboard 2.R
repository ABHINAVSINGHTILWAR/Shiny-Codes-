ui <- fluidPage(
	titlePanel("Inc's Top 5000"),
	sidebarLayout(
		sidebarPanel(
			radioButtons("ui.industry", label = "", choices = list(
				"Advertising & Marketing" = "Advertising & Marketing",
				"IT Services" = "IT Services",
				"Human Resources" = "Human Resources",
				"Retail" = "Retail",
				"Insurance" = "Insurance",
				"Logistics & Transportation" = "Logistics & Transportation",
				"Construction" = "Construction",
				"Business Products & Services Manufacturing" = "Business Products & Services Manufacturing",
				"Government Services" = "Government Services",
				"Financial Services" = "Financial Services",
				"Travel" = "Travel",
				"Health" = "Health",
				"Consumer Products & Services Environmental Services" = "Consumer Products & Services Environmental Services",
				"Software" = "Software",
				"Engineering" = "Engineering",
				"Computer Hardware" = "Computer Hardware",
				"Media" = "Media",
				"Food & Beverage" = "Food & Beverage",
				"Telecommunications" = "Telecommunications",
				"Security" = "Security",
				"Education" = "Education",
				"Energy" = "Energy",
				"Real Estate" = "Real Estate")
				)
		),
		mainPanel(textOutput("mytext"),
							plotOutput("inc.plot")
		)
	)
)

library(ggplot2)
library(scales)
inc.df <- read.csv('Top_5000_Companies_from_INC.csv')

server <- function(input, output) {
	output$mytext <- renderText({input$ui.industry})
	output$inc.plot <- renderPlot({ggplot(data = inc.df[inc.df$industry == input$ui.industry,], aes(x = revenue, y = growth)) + 
			geom_point(shape = 21, color = 'gray', size = 4, fill = 'coral1', alpha = .5)}) 
}

shinyApp(ui = ui, server = server)
