#' @title
#' Drop NA rows.
#'
#' @description
#' Drop rows with all missing (\code{NA}) values.
#'
#' @details
#' Drop rows that have no observed values, i.e., all values in the row are
#' missing (\code{NA}), excluding the ignored columns.
#'
#' @param data Dataframe to drop rows from.
#' @param ignore Names of columns to ignore for determining whether each row had
#' all missing values.
#'
#' @return A dataframe with rows removed that had all missing values in
#' non-ignored columns.
#'
#' @family dataManipulation
#' @family dataEvaluations
#'
#' @importFrom stats rnorm
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' df <- expand.grid(ID = 1:100, time = c(1, 2, 3))
#' df <- df[order(df$ID),]
#' row.names(df) <- NULL
#' df$score1 <- rnorm(nrow(df))
#' df$score2 <- rnorm(nrow(df))
#' df$score3 <- rnorm(nrow(df))
#' df[sample(1:nrow(df), size = 100), c("score1","score2","score3")] <- NA
#'
#' # Drop Rows with All NA in Non-Ignored Columns
#' dropRowsWithAllNA(df, ignore = c("ID","time"))

dropRowsWithAllNA <- function(data, ignore = NULL){
  if(is.null(ignore)){
    naRows <- apply(data, 1, function(x) all(is.na(x)))
  } else{
    naRows <- apply(data[,names(data) %ni% ignore], 1, function(x) all(is.na(x)))
  }
  data <- data[!naRows,]
  return(data)
}
