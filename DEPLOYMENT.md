# Deployment Guide

This guide provides detailed instructions for deploying the Shiny application to various platforms.

## Quick Start: Deploy to shinyapps.io

The fastest way to get your app online is using shinyapps.io's free tier.

### Step 1: Create Account

1. Go to https://www.shinyapps.io/
2. Sign up for a free account
3. Log in to your account

### Step 2: Get Your Credentials

1. Click on your name in the top right corner
2. Select "Tokens" from the dropdown
3. Click "Show" next to your token
4. Click "Show Secret" to reveal your secret key
5. Keep this information handy for the next step

### Step 3: Install rsconnect Package

Open R or RStudio and run:

```r
install.packages("rsconnect")
```

### Step 4: Configure Your Account

In R, run the following command with your actual credentials:

```r
rsconnect::setAccountInfo(
  name = "YOUR_ACCOUNT_NAME",
  token = "YOUR_TOKEN",
  secret = "YOUR_SECRET"
)
```

### Step 5: Deploy

You have two options:

**Option A - Use the deployment script:**

```r
source("deploy.R")
```

**Option B - Deploy manually:**

```r
rsconnect::deployApp(appName = "my-first-r-project")
```

Your app will be live at: `https://YOUR_ACCOUNT_NAME.shinyapps.io/my-first-r-project/`

## Automated Deployment with GitHub Actions

For automatic deployment when you push changes to GitHub:

### Setup

1. Add the following secrets to your GitHub repository (Settings > Secrets and variables > Actions):
   - `SHINYAPPS_ACCOUNT`: Your shinyapps.io account name
   - `SHINYAPPS_TOKEN`: Your token from shinyapps.io
   - `SHINYAPPS_SECRET`: Your secret from shinyapps.io

2. The workflow file (`.github/workflows/deploy.yml`) is already included

3. The app will automatically deploy when:
   - You push changes to the `main` branch that affect `app.R`
   - You manually trigger the workflow from the Actions tab

**Important:** The workflow is configured for the `main` branch only. If you're working on a feature branch (like `copilot/create-shiny-application`), the workflow will not run automatically. You need to:
- Merge your PR to main first, OR
- Update `.github/workflows/deploy.yml` to include your branch in the `branches` list

### Manual Trigger

1. Go to your repository on GitHub
2. Click on "Actions" tab
3. Select "Deploy Shiny App" workflow
4. Click "Run workflow"
5. Select the branch you want to deploy from
6. Click "Run workflow" button

**Note:** Manual triggers work on any branch, but you still need the GitHub secrets configured.

## Deploy with Docker

For containerized deployment:

### Local Docker Deployment

1. Build the Docker image:

```bash
docker build -t my-shiny-app .
```

2. Run the container:

```bash
docker run -p 3838:3838 my-shiny-app
```

3. Open http://localhost:3838 in your browser

### Deploy to Hugging Face Spaces

1. Create a new Space at https://huggingface.co/new-space
2. Choose "Docker" as the SDK
3. Clone the Space repository locally
4. Copy these files to the Space repository:
   - `app.R`
   - `Dockerfile`
5. Commit and push to the Space repository
6. Your app will be live at `https://huggingface.co/spaces/YOUR_USERNAME/SPACE_NAME`

## Self-Hosted Deployment

### Using Shiny Server (Linux)

1. Install Shiny Server on your Linux server:

```bash
# Ubuntu/Debian
sudo apt-get install gdebi-core
wget https://download3.rstudio.org/ubuntu-18.04/x86_64/shiny-server-1.5.20.1002-amd64.deb
sudo gdebi shiny-server-1.5.20.1002-amd64.deb
```

2. Copy your app to the Shiny Server directory:

```bash
sudo cp -r /path/to/my-first-r-project /srv/shiny-server/
```

3. Access your app at: `http://your-server-ip:3838/my-first-r-project/`

### Using Shiny Server (Docker)

1. Use the provided Dockerfile
2. Deploy to your preferred container hosting service:
   - AWS ECS
   - Google Cloud Run
   - Azure Container Instances
   - DigitalOcean App Platform

## Enterprise Deployment

### RStudio Connect / Posit Connect

1. Install RStudio Connect on your server
2. Use rsconnect to deploy:

```r
rsconnect::deployApp(
  server = "https://your-connect-server.com",
  appName = "my-first-r-project"
)
```

## Troubleshooting

### Common Issues

**"Unable to locate manifest.json" error:**
- This error occurs when rsconnect can't automatically generate the deployment manifest
- Solution 1: Ensure you're running `rsconnect::deployApp()` from the directory containing `app.R`
- Solution 2: Use the updated `deploy.R` script which explicitly sets the app directory
- Solution 3: Specify the appDir parameter: `rsconnect::deployApp(appDir = ".")`
- Solution 4: Make sure the DESCRIPTION file is present in your app directory
- Solution 5: Try force update: `rsconnect::deployApp(forceUpdate = TRUE)`

**"Account not configured" error:**
- Make sure you've run `rsconnect::setAccountInfo()` with your credentials
- Verify credentials are correct by checking `rsconnect::accounts()`

**Deployment fails with package errors:**
- Ensure all required packages are listed in your app
- The Shiny package is automatically detected and installed
- Check package compatibility with the R version on shinyapps.io

**App crashes after deployment:**
- Check the logs in your shinyapps.io dashboard
- Verify the app runs locally with `shiny::runApp()`
- Make sure you're using compatible R package versions

**GitHub Actions fails:**
- Verify all three secrets are correctly set in GitHub
- Check the Actions log for specific error messages
- Ensure your shinyapps.io account has available deployment slots

**rsconnect directory issues:**
- Delete the `rsconnect` folder in your app directory if deployment fails repeatedly
- The folder will be regenerated automatically on next deployment

## Resource Limits

### shinyapps.io Free Tier

- 5 applications
- 25 active hours per month
- Up to 1 GB RAM per application
- Sleeps after 15 minutes of inactivity

For higher limits, consider upgrading to a paid plan.

## Next Steps

After deployment:
- Share your app URL with users
- Monitor usage in the shinyapps.io dashboard
- Update the app by running `rsconnect::deployApp()` again
- Consider upgrading if you need more resources
