#' @title
#' Repeatability.
#'
#' @description
#' Estimate the repeatability of a measure's scores across two time points.
#'
#' @details
#' Estimates the coefficient of repeatability (CR), bias, and the lower and
#' upper limits of agreement (LOA).
#'
#' @param measure1 Vector of scores from the measure at time 1.
#' @param measure2 Vector of scores from the measure at time 2.
#'
#' @return
#' Dataframe with the coefficient of repeatability (\code{CR}), bias, the lower
#' limit of agreement (\code{lowerLOA}), and the upper limit of agreement
#' (\code{upperLOA}). Also generates a Bland-Altman plot with a solid black
#' reference line (indicating a difference of zero), a dashed red line
#' indicating the bias, and dashed blue lines indicating the limits of
#' agreement.
#'
#' @family reliability
#'
#' @importFrom stats sd qnorm rnorm
#'
#' @export
#'
#' @examples
#' v1 <- rnorm(1000, mean = 100, sd = 15)
#' v2 <- v1 + rnorm(1000, mean = 1, sd = 3)
#' repeatability(v1, v2)

repeatability <- function(measure1, measure2){
  cr <- qnorm(.975) * sd((measure1 - measure2), na.rm = TRUE)
  bias <- mean((measure2 - measure1), na.rm = TRUE)
  lowerLOA <- bias - cr
  upperLOA <- bias + cr

  means <- rowMeans(cbind(measure1, measure2), na.rm = TRUE)
  differences <- measure2 - measure1

  output <- data.frame(
    cr = cr,
    bias = bias,
    lowerLOA = lowerLOA,
    upperLOA = upperLOA
  )

  plot(means, differences,
       xlab = "Mean of measurements (measure2 and measure1)",
       ylab = "Difference of measurements (measure2 \u2212 measure1)")
  abline(h = 0)
  abline(h = bias, lty = 2, col = "red")
  abline(h = lowerLOA, lty = 2, col = "blue")
  abline(h = upperLOA, lty = 2, col = "blue")

  return(output)
}
