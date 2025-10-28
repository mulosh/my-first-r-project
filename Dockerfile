FROM rocker/shiny:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
RUN mkdir -p /srv/shiny-server/my-first-r-project

# Copy app files
COPY app.R /srv/shiny-server/my-first-r-project/

# Set working directory
WORKDIR /srv/shiny-server/my-first-r-project

# Expose port
EXPOSE 3838

# Run the app
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/my-first-r-project', host='0.0.0.0', port=3838)"]
