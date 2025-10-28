# my-first-r-project
"My first R project on GitHub"

## Shiny Application: Interactive Data Explorer

This project contains an interactive Shiny web application for exploring and visualizing data.

### Features

- **Interactive Data Exploration**: Explore built-in R datasets (mtcars, iris, faithful)
- **Dynamic Visualizations**: Generate histograms with customizable parameters
- **Multiple Views**: 
  - Plot view with interactive histogram
  - Summary statistics view
  - Data table view
- **Customization Options**:
  - Select different datasets
  - Choose numeric variables to visualize
  - Adjust number of bins
  - Change color themes

### Prerequisites

- R (version 4.0 or higher)
- Shiny package

### Installation

1. Install R from [CRAN](https://cran.r-project.org/)

2. Install the Shiny package:
   
   **Option 1 - From R console (recommended):**
   ```r
   install.packages("shiny")
   ```

   **Option 2 - On Ubuntu/Debian systems:**
   ```bash
   # Install R if not already installed
   sudo apt-get update
   sudo apt-get install r-base
   
   # Install Shiny from repository (Ubuntu 20.04+)
   sudo apt-get install r-cran-shiny
   ```

### Running the Application

To run the Shiny application:

```r
# In R console
shiny::runApp("app.R")
```

Or from the command line:
```bash
R -e "shiny::runApp('app.R')"
```

The application will start and open in your default web browser. If it doesn't open automatically, navigate to the URL shown in the console (typically `http://127.0.0.1:XXXX`).

### Usage

1. **Select a Dataset**: Choose from mtcars, iris, or faithful datasets
2. **Choose a Variable**: Pick a numeric variable to visualize
3. **Adjust Bins**: Use the slider to change the number of histogram bins
4. **Select Color**: Choose your preferred color scheme
5. **Explore Tabs**: Switch between Plot, Summary, and Data Table views

### Project Structure

```
my-first-r-project/
├── .github/
│   └── workflows/
│       └── deploy.yml       # GitHub Actions deployment workflow
├── app.R                    # Main Shiny application file
├── rsconnect-config.R       # Deployment configuration
├── .Renviron                # Environment variables (placeholders)
└── README.md                # This file
```

### Deployment

This application includes automated deployment to shinyapps.io using GitHub Actions.

#### Automated Deployment

The application automatically deploys to shinyapps.io when changes are pushed to the `main` branch, or can be triggered manually via GitHub Actions.

**Setup Requirements:**

1. Create a shinyapps.io account at [shinyapps.io](https://www.shinyapps.io/)

2. Get your shinyapps.io credentials:
   - Log in to shinyapps.io
   - Go to Account → Tokens
   - Click "Show" to reveal your token and secret

3. Add GitHub Secrets to your repository:
   - Go to your repository on GitHub
   - Navigate to Settings → Secrets and variables → Actions
   - Add the following secrets:
     - `SHINYAPPS_NAME`: Your shinyapps.io account name
     - `SHINYAPPS_TOKEN`: Your shinyapps.io token
     - `SHINYAPPS_SECRET`: Your shinyapps.io secret

**Deployment Triggers:**

- **Automatic**: Pushes to the `main` branch
- **Manual**: Via GitHub Actions workflow dispatch

#### Manual Deployment

To deploy manually using R:

```r
# Install rsconnect if not already installed
install.packages("rsconnect")

# Set up your shinyapps.io credentials
rsconnect::setAccountInfo(
  name   = "your-account-name",
  token  = "your-token",
  secret = "your-secret"
)

# Deploy the app
rsconnect::deployApp(appDir = ".", appName = "my-first-r-project")
```

Or use the helper script:

```r
# Set environment variables in your ~/.Renviron file
source("rsconnect-config.R")
deploy_to_shinyapps()
```

### License

This project is open source and available for educational purposes.
