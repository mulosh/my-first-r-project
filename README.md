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
   ```r
   install.packages("shiny")
   ```

   Or on Ubuntu/Debian:
   ```bash
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
├── app.R          # Main Shiny application file
└── README.md      # This file
```

### License

This project is open source and available for educational purposes.
