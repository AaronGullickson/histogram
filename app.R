#Histogram app that will allow users to adjust the bin width
#using movie runtime as the variable

library(shiny)
library(ggplot2)

#load the movies dataset
load("movies.RData")
x <- na.omit(movies$Runtime)  # Runtime of movies

server <- function(input, output) {
    
    output$distPlot <- renderPlot({
        ggplot(movies, aes(x=Runtime))+
            geom_histogram(binwidth=input$width, fill="skyblue", color="black")+
            labs(x="movie runtime (in minutes)", y="frequency (count)")+
            theme_bw()
        
        #determine the bins by user-input width
        #bins <- seq(0, by=input$width, length.out = 1+(max(x)/input$width))
        
        # draw the histogram with the specified bins
        #hist(x, breaks = bins, col = 'skyblue', border = 'black', 
        #     main="Histogram of movie runtime in minutes",
        #     xlab="Runtime (in minutes)")
    })
}

ui <- shinyUI(fluidPage(
    
    # Title
    titlePanel(h2("Histogram Example", align="center")),
    
    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("width",
                        "Width of bins (in minutes):",
                        min = 1,
                        max = 30,
                        value = 5, post=" minutes"),
            helpText("Notice how the appearance of the histogram changes as",
                     "you change the width of the bins. What do you think is a good bin width",
                     "for understanding the distribution? What happens as your bin width gets",
                     "very small? What happens as your bin width gets very big?")
        ),
        mainPanel(plotOutput("distPlot"))
    )
))

shinyApp(ui = ui, server = server)