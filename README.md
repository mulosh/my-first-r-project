# my-first-r-project
"My first R project on GitHub"

## Shiny Application

This repository contains a simple Shiny web application that demonstrates interactive data visualization.

### Features

- Interactive histogram visualization using the Old Faithful geyser dataset
- Adjustable number of bins via slider control
- Summary statistics display
- Clean, user-friendly interface

### Requirements

- R (version 3.6.0 or higher recommended)
- Shiny package

### Installation

1. Install R from [CRAN](https://cran.r-project.org/)
2. Install the Shiny package:

```r
install.packages("shiny")
```

### Running the Application

To run the Shiny application locally:

1. Clone this repository:
```bash
git clone https://github.com/mulosh/my-first-r-project.git
cd my-first-r-project
```

2. Open R or RStudio in the project directory

3. Run the app:
```r
shiny::runApp()
```

Alternatively, if using RStudio, simply open `app.R` and click the "Run App" button.

The application will open in your default web browser or in RStudio's viewer pane.

### About the Data

The application uses the built-in `faithful` dataset in R, which contains information about the Old Faithful geyser in Yellowstone National Park, Wyoming, USA. The histogram displays the distribution of waiting times between eruptions.
