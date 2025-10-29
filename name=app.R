# Simple Shiny app starter
# - Use data/processed/example.csv if present
# - Otherwise uses a generated example dataset

library(shiny)
library(tidyverse)
source(file.path("R", "helpers.R"))

ui <- fluidPage(
  titlePanel("My First Shiny App"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload CSV (optional)", accept = c(".csv")),
      uiOutput("col_select_ui"),
      checkboxInput("show_smooth", "Show trend line", TRUE),
      numericInput("sample_n", "Sample rows for plot (0 = all)", value = 0, min = 0),
      hr(),
      actionButton("reload", "Reload Example Data")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("scatter")),
        tabPanel("Data", DT::dataTableOutput("table")),
        tabPanel("Summary", verbatimTextOutput("summary"))
      )
    )
  )
)

server <- function(input, output, session) {
  df_data <- reactiveVal(NULL)

  load_example <- function() {
    if (file.exists("data/processed/example.csv")) {
      readr::read_csv("data/processed/example.csv")
    } else {
      tibble(x = rnorm(200), y = x * 2 + rnorm(200))
    }
  }

  observeEvent(input$reload, {
    df_data(load_example())
  }, ignoreNULL = FALSE)

  observeEvent(input$file, {
    req(input$file)
    df <- readr::read_csv(input$file$datapath)
    df_data(df)
  })

  output$col_select_ui <- renderUI({
    df <- df_data()
    if (is.null(df)) return(NULL)
    num_cols <- names(df)[vapply(df, is.numeric, logical(1))]
    if (length(num_cols) < 1) {
      p("No numeric columns found in data.")
    } else {
      tagList(
        selectInput("xcol", "X column", choices = num_cols, selected = num_cols[[1]]),
        selectInput("ycol", "Y column", choices = num_cols, selected = num_cols[[min(2, length(num_cols))]])
      )
    }
  })

  plot_df <- reactive({
    req(df_data())
    df <- df_data()
    if (!is.null(input$sample_n) && input$sample_n > 0 && input$sample_n < nrow(df)) {
      df %>% slice_sample(n = input$sample_n)
    } else {
      df
    }
  })

  output$scatter <- renderPlot({
    req(plot_df(), input$xcol, input$ycol)
    p <- ggplot(plot_df(), aes_string(x = input$xcol, y = input$ycol)) +
      geom_point() +
      theme_minimal()
    if (isTRUE(input$show_smooth)) p <- p + geom_smooth(method = "lm", se = TRUE)
    p
  })

  output$table <- DT::renderDataTable({
    req(df_data())
    DT::datatable(df_data())
  })

  output$summary <- renderPrint({
    req(df_data())
    req(input$ycol)
    summarize_example(df_data(), input$ycol)
  })
}

shinyApp(ui, server)
