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

## Deployment

### Deploy to shinyapps.io

The easiest way to deploy this Shiny application is using [shinyapps.io](https://www.shinyapps.io/), which offers a free tier.

#### Prerequisites

1. Create a free account at https://www.shinyapps.io/
2. Install the rsconnect package:

```r
install.packages("rsconnect")
```

#### Deployment Steps

1. Configure your shinyapps.io account in R (you'll find these credentials in your shinyapps.io account dashboard):

```r
rsconnect::setAccountInfo(
  name="<ACCOUNT_NAME>",
  token="<TOKEN>",
  secret="<SECRET>"
)
```

2. Deploy the application:

```r
rsconnect::deployApp()
```

Your app will be available at `https://<ACCOUNT_NAME>.shinyapps.io/my-first-r-project/`

#### Using the Deployment Script

Alternatively, use the included deployment script:

```r
source("deploy.R")
```

### Other Deployment Options

#### Hugging Face Spaces

1. Create a new Space at https://huggingface.co/spaces
2. Select "Docker" as the SDK
3. Push this repository to the Space
4. Add the provided `Dockerfile` for R Shiny deployment

#### Self-Hosted with Shiny Server

For self-hosting, install [Shiny Server](https://posit.co/products/open-source/shinyserver/) on your server and copy the app files to the appropriate directory.

#### RStudio Connect / Posit Connect

For enterprise deployment, use [RStudio Connect](https://posit.co/products/enterprise/connect/) with the rsconnect package.
