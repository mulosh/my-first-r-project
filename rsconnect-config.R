# rsconnect-config.R
# Usage:
# 1) Populate environment variables (e.g., via .Renviron locally or CI secrets).
# 2) Restart R so that environment variables are available.
# 3) source("rsconnect-config.R") or call functions below from scripts/CI.

if (!requireNamespace("rsconnect", quietly = TRUE)) {
  install.packages("rsconnect", repos = "https://cloud.r-project.org")
}
library(rsconnect)

# Helper to test if an env var is set (non-empty)
.env_set <- function(name) {
  val <- Sys.getenv(name, unset = "")
  nzchar(val)
}

# ---------- shinyapps.io (hosted) ----------
if (.env_set("SHINYAPPS_NAME") && .env_set("SHINYAPPS_TOKEN") && .env_set("SHINYAPPS_SECRET")) {
  rsconnect::setAccountInfo(
    name   = Sys.getenv("SHINYAPPS_NAME"),
    token  = Sys.getenv("SHINYAPPS_TOKEN"),
    secret = Sys.getenv("SHINYAPPS_SECRET")
  )
} else {
  message("shinyapps.io credentials not fully set — skipping rsconnect::setAccountInfo for shinyapps.io")
}

deploy_to_shinyapps <- function(appDir = ".", appName = NULL, account = Sys.getenv("SHINYAPPS_NAME")) {
  if (!.env_set("SHINYAPPS_NAME")) stop("SHINYAPPS_NAME not set")
  if (!.env_set("SHINYAPPS_TOKEN") || !.env_set("SHINYAPPS_SECRET")) stop("shinyapps.io token/secret not set")
  rsconnect::deployApp(appDir = appDir, appName = appName, account = account)
}

# ---------- Posit Connect (self-hosted / enterprise) ----------
if (.env_set("CONNECT_ACCOUNT") && .env_set("CONNECT_TOKEN") && .env_set("CONNECT_SECRET") && .env_set("CONNECT_SERVER")) {
  rsconnect::setAccountInfo(
    name   = Sys.getenv("CONNECT_ACCOUNT"),
    token  = Sys.getenv("CONNECT_TOKEN"),
    secret = Sys.getenv("CONNECT_SECRET"),
    server = Sys.getenv("CONNECT_SERVER")
  )
} else {
  message("Posit Connect credentials not fully set — skipping rsconnect::setAccountInfo for Connect")
}

deploy_to_connect <- function(appDir = ".", appName = NULL, account = Sys.getenv("CONNECT_ACCOUNT"), server = Sys.getenv("CONNECT_SERVER")) {
  if (!.env_set("CONNECT_ACCOUNT")) stop("CONNECT_ACCOUNT not set")
  if (!.env_set("CONNECT_TOKEN") || !.env_set("CONNECT_SECRET") || !.env_set("CONNECT_SERVER")) stop("Posit Connect token/secret/server not set")
  rsconnect::deployApp(appDir = appDir, account = account, server = server, appName = appName)
}