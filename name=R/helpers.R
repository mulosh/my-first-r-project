# Reusable helper functions for the app

#' Summarize a numeric column (mean, sd, n)
#' @param df data.frame or tibble
#' @param colname string name of numeric column
#' @return tibble with summary statistics
summarize_example <- function(df, colname) {
  if (is.null(df) || !colname %in% names(df)) {
    return(tibble::tibble(name = colname, n = 0, mean = NA_real_, sd = NA_real_))
  }
  col <- df[[colname]]
  tibble::tibble(
    name = colname,
    n = sum(!is.na(col)),
    mean = mean(col, na.rm = TRUE),
    sd = sd(col, na.rm = TRUE)
  )
}
