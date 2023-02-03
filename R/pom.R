#' @title
#' Proportion of Maximum (POM).
#'
#' @description
#' Calculate the proportion of maximum (POM) score given a minimum and maximum
#' score.
#'
#' @details
#' The minimum and maximum score for calculating the proportion of maximum could
#' be the possible or observed minimum and maximum, respectively. Using the
#' possible minimum and maximum would yield the proportion of maximum possible
#' score. Using the observed minimum and maximum would yield the proportion of
#' minimum and maximum observed score. If the minimum and maximum possible
#' scores are not specified, the observed minimum and maximum are used.
#'
#' @param data The vector of data.
#' @param min The minimum possible or observed value.
#' @param max The maximum possible or observed value.
#'
#' @return Proportion of maximum possible or observed values.
#'
#' @family conversion
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' v1 <- sample(1:9, size = 1000, replace = TRUE)
#'
#' # Calculate Proportion of Maximum Possible (by specifying the minimum and maximum possible)
#' pom(v1, min = 0, max = 10)
#'
#' # Calculate Proportion of Maximum Observed
#' pom(v1)

pom <- function(data, min = NULL, max = NULL){
  if(is.null(min)){
    min <- min(data, na.rm = TRUE)
  }

  if(is.null(max)){
    max <- max(data, na.rm = TRUE)
  }

  proportionOfMaximum <- (data - min) / (max - min)

  return(proportionOfMaximum)
}
