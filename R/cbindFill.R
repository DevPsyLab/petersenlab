#' @title
#' Column Bind and Fill.
#'
#' @description
#' Column bind dataframes and fill with \code{NA}s.
#'
#' @details
#' Binds columns of two or more dataframes together, and fills in missing rows.
#'
#' @param ... Names of multiple dataframes.
#'
#' @return
#' Dataframe with columns binded together.
#'
#' @family dataManipulation
#'
#' @importFrom stats rnorm
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' df1 <- data.frame(a = rnorm(5), b = rnorm(5))
#' df2 <- data.frame(c = rnorm(4), d = rnorm(4))
#'
#' # Column Bind and Fill
#' columnBindFill(df1, df2)
#'
#' @seealso
#' \url{https://stackoverflow.com/questions/7962267/cbind-a-dataframe-with-an-empty-dataframe-cbind-fill/7962286#7962286}

columnBindFill <- function(...){
  nm <- list(...)
  nm <- lapply(nm, as.matrix)
  n <- max(sapply(nm, nrow))
  do.call(cbind, lapply(nm, function (x) rbind(x, matrix(, n-nrow(x), ncol(x)))))
}
