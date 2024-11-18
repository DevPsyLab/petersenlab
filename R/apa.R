#' @title
#' APA Format
#'
#' @description
#' Format decimals and leading zeroes. Adapted from the MOTE package.
#'
#' @details
#' Formats decimals and leading zeroes for creating reports in scientific style,
#' to be consistent with American Psychological Association (APA) format. This
#' function creates "pretty" character vectors from numeric variables for
#' printing as part of a report. The value can take a single number, matrix,
#' vector, or multiple columns from a data frame, as long as they are numeric.
#' The values will be coerced into numeric if they are characters or logical
#' values, but this process may result in an error if values are truly
#' alphabetical.
#'
#' @param value A set of numeric values, either a single number, vector, or set
#' of columns.
#' @param decimals The number of decimal points desired in the output.
#' @param leading Logical value: \code{TRUE} for leading zeroes on decimals
#'    and \code{FALSE} for no leading zeroes on decimals. The default is
#'    \code{TRUE}.
#'
#' @return Value(s) in the format specified, with the number of decimals places
#' indicated and with or without a leading zero, as indicated.
#'
#' @family formatting
#'
#' @importFrom stats lm update anova
#'
#' @examples
#' apa(value = 0.54674, decimals = 3, leading = TRUE)
#'
#' @seealso
#' \url{https://github.com/doomlab/MOTE}

#' @rdname apa
#' @export

apa <- function(value, decimals = 3, leading = TRUE) {
  if(missing(value)) {
    stop("Be sure to include the numeric values you wish to format.")
  }

  if(!is.numeric(value)){
    stop("The values you provided are not numeric.")
  }

  if(leading == TRUE) {
    sigDigits <- decimals + 1
    formnumber <- format(
      round(as.numeric(value),
            decimals),
      digits = sigDigits,
      nsmall = decimals)
  }
  if(leading == FALSE) {
    formnumber <- sub(
      "^(-?)0.",
      "\\1.",
      sprintf(
        paste("%.", decimals, "f", sep = ""),
        as.numeric(value)))
  }

  return(formnumber)
}
