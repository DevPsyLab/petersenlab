#' @title
#' Percentile to T-Score Conversion.
#'
#' @description
#' Conversion of percentile ranks to T-scores.
#'
#' @details
#' Converts percentile ranks to the equivalent T-scores.
#'
#' @param percentileRank Vector of percentile ranks.
#'
#' @return Vector of T-scores.
#'
#' @family conversion
#'
#' @importFrom stats qnorm
#'
#' @export
#'
#' @examples
#' percentileRanks <- c(1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 99)
#'
#' percentileToTScore(percentileRanks)

percentileToTScore <- function(percentileRank){
  qnorm(percentileRank/100) * 10 + 50
}
