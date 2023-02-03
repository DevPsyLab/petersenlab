#' @title
#' Drop NA columns.
#'
#' @description
#' Drop columns with all missing (\code{NA}) values.
#'
#' @details
#' Drop columns that have no observed values, i.e., all values in the column are
#' missing (\code{NA}), excluding the ignored columns.
#'
#' @param data Dataframe to drop columns from.
#' @param ignore Names of columns to ignore for determining whether each row had
#' all missing values.
#'
#' @return A dataframe with columns removed that had all missing values in
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
#' df <- expand.grid(ID = 1:100, time = c(1, 2, 3), rater = c(1, 2),
#' naCol1 = NA, naCol2 = NA)
#' df <- df[order(df$ID),]
#' row.names(df) <- NULL
#' df$score1 <- rnorm(nrow(df))
#' df$score2 <- rnorm(nrow(df))
#' df$score3 <- rnorm(nrow(df))
#' df[sample(1:nrow(df), size = 100), c("score1","score2","score3")] <- NA
#'
#' # Drop Rows with All NA in Non-Ignored Columns
#' dropColsWithAllNA(df)
#' dropColsWithAllNA(df, ignore = c("naCol2"))

dropColsWithAllNA <- function(data, ignore = NULL){
  if(is.null(ignore)){
    naCols <- apply(data, 2, function(x) all(is.na(x)))
  } else{
    naCols <- apply(data[,names(data) %ni% ignore], 2, function(x) all(is.na(x)))
  }
  data <- data[,!naCols]
  return(data)
}
