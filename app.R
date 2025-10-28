# My First Shiny Application
# A simple interactive web application built with Shiny

library(shiny)

# Define UI for application
ui <- fluidPage(
    # Application title
    titlePanel("My First Shiny Application"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            
            hr(),
            
            helpText("This is a simple Shiny application that demonstrates",
                     "interactive visualization. Move the slider to change",
                     "the number of bins in the histogram.")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            
            hr(),
            
            h4("Summary Statistics"),
            verbatimTextOutput("summary")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
    
    output$summary <- renderPrint({
        x <- faithful[, 2]
        summary(x)
    })
}

# Run the application
shinyApp(ui = ui, server = server)
