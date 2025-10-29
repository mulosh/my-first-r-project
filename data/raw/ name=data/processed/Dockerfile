# Dockerfile to run the Shiny app using rocker/shiny
FROM rocker/shiny:latest

# Install system dependencies if needed (uncomment and adjust)
# RUN apt-get update && apt-get install -y libxml2-dev libcurl4-openssl-dev libssl-dev

# Copy app
COPY . /srv/shiny-server/my-first-r-project
WORKDIR /srv/shiny-server/my-first-r-project

# Install R package dependencies (use renv if present)
RUN R -e "install.packages(c('shiny', 'tidyverse', 'DT'))"

# expose shiny-server port
EXPOSE 3838

# start shiny-server (default command)
CMD ["/usr/bin/shiny-server"]
