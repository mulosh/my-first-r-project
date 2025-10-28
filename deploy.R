# Deployment Script for Shiny Application
# This script helps deploy the application to shinyapps.io

# Check if rsconnect is installed
if (!require("rsconnect")) {
  message("Installing rsconnect package...")
  install.packages("rsconnect")
  library(rsconnect)
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
  
  # Deploy the application
  rsconnect::deployApp(
    appName = "my-first-r-project",
    appTitle = "My First Shiny Application",
    launch.browser = TRUE
  )
  
  message("Deployment complete!")
  message("Your app should open in your browser shortly.")
}

# Run deployment
deploy_app()
