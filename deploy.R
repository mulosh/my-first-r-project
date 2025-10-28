# Deployment Script for Shiny Application
# This script helps deploy the application to shinyapps.io

# Check if rsconnect is installed
if (!require("rsconnect")) {
  message("Installing rsconnect package...")
  install.packages("rsconnect")
  library(rsconnect)
}

# Check if shiny is installed
if (!require("shiny")) {
  message("Installing shiny package...")
  install.packages("shiny")
  library(shiny)
}

# Function to deploy the application
deploy_app <- function() {
  # Check if account is configured
  accounts <- rsconnect::accounts()
  
  if (nrow(accounts) == 0) {
    message("No shinyapps.io account configured.")
    message("Please configure your account first:")
    message("  1. Go to https://www.shinyapps.io/ and sign up/login")
    message("  2. Click on your name in the top right > Tokens")
    message("  3. Click 'Show' on your token, then 'Show Secret'")
    message("  4. Run the following command with your credentials:")
    message("")
    message("rsconnect::setAccountInfo(name='<ACCOUNT>', token='<TOKEN>', secret='<SECRET>')")
    message("")
    return(invisible(FALSE))
  }
  
  message("Deploying application to shinyapps.io...")
  message("Account: ", accounts$name[1])
  message("Working directory: ", getwd())
  
  # Ensure we're in the correct directory (where app.R is located)
  if (!file.exists("app.R")) {
    stop("Error: app.R not found in current directory. Please run this script from the app directory.")
  }
  
  # Deploy the application
  # The appDir parameter ensures we deploy from the current directory
  rsconnect::deployApp(
    appDir = ".",
    appName = "my-first-r-project",
    appTitle = "My First Shiny Application",
    appFiles = c("app.R", "DESCRIPTION"),
    launch.browser = TRUE,
    forceUpdate = TRUE
  )
  
  message("Deployment complete!")
  message("Your app should open in your browser shortly.")
}

# Run deployment
deploy_app()
