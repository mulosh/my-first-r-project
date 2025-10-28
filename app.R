# Shiny Application: Interactive Data Explorer
# This is a simple Shiny web application demonstrating interactive data visualization

library(shiny)

# Define UI for the application
ui <- fluidPage(
    # Application title
    titlePanel("Interactive Data Explorer"),
    
    # Sidebar layout with input and output definitions
    sidebarLayout(
        sidebarPanel(
            # Input: Select dataset
            selectInput("dataset", 
                        "Choose a dataset:",
                        choices = c("mtcars", "iris", "faithful")),
            
            # Input: Select variable for histogram
            uiOutput("variable_selector"),
            
            # Input: Number of bins for histogram
            sliderInput("bins",
                        "Number of bins:",
                        min = 5,
                        max = 50,
                        value = 30),
            
            # Input: Color selection
            selectInput("color",
                        "Choose color:",
                        choices = c("steelblue", "darkred", "darkgreen", "purple", "orange")),
            
            # Add some information
            hr(),
            helpText("This application allows you to explore built-in R datasets interactively.",
                     "Select a dataset, choose a numeric variable, and adjust the histogram parameters.")
        ),
        
        # Main panel for displaying outputs
        mainPanel(
            # Output: Tabset with plot, summary, and data table
            tabsetPanel(type = "tabs",
                        tabPanel("Plot", 
                                 plotOutput("distPlot"),
                                 br(),
                                 textOutput("plot_description")),
                        tabPanel("Summary", 
                                 verbatimTextOutput("summary")),
                        tabPanel("Data Table", 
                                 tableOutput("table"))
            )
        )
    )
)

# Define server logic
server <- function(input, output, session) {
    
    # Reactive expression to get the selected dataset
    datasetInput <- reactive({
        switch(input$dataset,
               "mtcars" = mtcars,
               "iris" = iris,
               "faithful" = faithful)
    })
    
    # Dynamic UI for variable selection based on dataset
    output$variable_selector <- renderUI({
        data <- datasetInput()
        numeric_vars <- names(data)[sapply(data, is.numeric)]
        
        selectInput("variable", 
                    "Choose a variable:",
                    choices = numeric_vars,
                    selected = numeric_vars[1])
    })
    
    # Reactive expression to get selected variable data
    selectedData <- reactive({
        req(input$variable)  # Require that variable is selected
        data <- datasetInput()
        data[[input$variable]]
    })
    
    # Generate histogram plot
    output$distPlot <- renderPlot({
        req(input$variable)  # Require that variable is selected
        
        x <- selectedData()
        min_val <- min(x, na.rm = TRUE)
        max_val <- max(x, na.rm = TRUE)
        
        # Handle edge case where all values are identical
        if (min_val == max_val) {
            bins <- seq(min_val - 0.5, max_val + 0.5, length.out = input$bins + 1)
        } else {
            bins <- seq(min_val, max_val, length.out = input$bins + 1)
        }
        
        hist(x, breaks = bins, col = input$color, border = "white",
             xlab = input$variable,
             main = paste("Distribution of", input$variable, "in", input$dataset))
    })
    
    # Generate plot description
    output$plot_description <- renderText({
        req(input$variable)
        x <- selectedData()
        paste("The histogram shows the distribution of", input$variable, 
              "with", input$bins, "bins.",
              "Mean:", round(mean(x, na.rm = TRUE), 2),
              "| Median:", round(median(x, na.rm = TRUE), 2),
              "| SD:", round(sd(x, na.rm = TRUE), 2))
    })
    
    # Generate summary of the dataset
    output$summary <- renderPrint({
        summary(datasetInput())
    })
    
    # Generate data table
    output$table <- renderTable({
        head(datasetInput(), n = 10)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
