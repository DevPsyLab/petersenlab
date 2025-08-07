#' @title
#' Robustly Load R Objects from a URL with Retry Logic
#'
#' @description
#' Attempts to load an R object from a URL using `load()`, with automatic
#' retries on failure. By default, it will retry indefinitely until successful.
#'
#' @details
#' This function wraps a call to `load(url(...))` in a retry loop. It is useful
#' when loading data from unstable remote sources (e.g., OSF, Dropbox, GitHub)
#' where temporary network errors may occur. Users may optionally set a maximum
#' number of retry attempts and a delay between retries. The function also
#' closes the connection after each attempt to prevent resource leaks.
#'
#' @param url A character string specifying the URL from which to load the
#' `.RData` object.
#' @param max_attempts The maximum number of attempts before giving up.
#' If `NULL` (the default), the function will retry indefinitely until
#' successful.
#' @param delay The number of seconds to wait between attempts (default = 2).
#' @param envir The environment into which the data should be loaded
#' (default is the global environment).
#' @param ... Parameters to pass to the `load()` function
#'
#' @return Invisibly returns `TRUE` if loading succeeds. On failure after
#' reaching the maximum number of attempts, an error is thrown.
#'
#' @family utilities
#'
#' @export
#'
#' @examples
#' # Example of a successful load (will do nothing if URL is valid)
#' \donttest{
#' robust_load("https://osf.io/download/yx5h6/")
#'
#' # Example with limited retries
#' robust_load("https://osf.io/download/yx5h6/", max_attempts = 4, delay = 1)
#'
#' # Example of a failing load, wrapped safely to pass R CMD check
#' try(
#'   robust_load("https://osf.io/download/THISISATEST/", max_attempts = 3, delay = 1),
#'   silent = TRUE
#' )
#' }

robust_load <- function(url, max_attempts = NULL, delay = 2, envir = .GlobalEnv, ...) {
  old_error_option <- getOption("error")
  on.exit(options(error = old_error_option), add = TRUE)
  options(error = NULL)

  attempt <- 1
  repeat {
    con <- url(url)
    result <- tryCatch({
      load(con, envir = envir, ...)
      close(con)
      return(invisible(TRUE)) # success
    }, error = function(e) {
      message(sprintf("Attempt %d failed: %s", attempt, e$message))
      try(close(con), silent = TRUE)
      if (!is.null(max_attempts) && attempt >= max_attempts) {
        stop("Failed to load after ", max_attempts, " attempts.")
      }
      attempt <<- attempt + 1
      Sys.sleep(delay)
      return(NULL)
    })
  }
}
