#' @title
#' Suppress Leading Zero.
#'
#' @description
#' Suppress leading zero of numbers.
#'
#' @details
#' [INSERT].
#'
#' @param value Numeric vector.
#'
#' @return Character vector of numbers without leading zeros.
#'
#' @family formatting
#'
#' @importFrom stats rnorm
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' v1 <- rnorm(1000)
#'
#' # Suppress Leading Zero
#' suppressLeadingZero(v1)

suppressLeadingZero <- function(value){
  numberOfCharacters <- nchar(gsub("[[:punct:]]", "", value)) - 1
  value[which(!is.na(value))] <- sub("^(-?)0.", "\\1.", sprintf(paste("%.", numberOfCharacters[which(!is.na(value))], "f", sep = ""), as.numeric(value[which(!is.na(value))])))

  return(value)
}
