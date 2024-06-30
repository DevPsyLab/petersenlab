#' @title
#' p-values.
#'
#' @description
#' Suppress the leading zero when printing p-values.
#'
#' @details
#' [INSERT].
#'
#' @param value The p-value.
#' @param digits Number of decimal digits for printing the p-value.
#'
#' @return p-value.
#'
#' @family formatting
#'
#' @export
#'
#' @examples
#' pValue(0.70)
#' pValue(0.04)
#' pValue(0.00002)

pValue <- function(value, digits = 3){
  if(value < .001){
    newValue <- "< .001"
  } else {
    newValue <- paste("=", suppressLeadingZero(specify_decimal(value, digits)), sep = "")
  }
  return(newValue)
}
