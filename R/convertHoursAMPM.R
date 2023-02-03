#' @title
#' Convert AM and PM Hours.
#'
#' @description
#' Convert hours to 24-hour time.
#'
#' @details
#' Convert hours to the number of hours in 24-hour time. You can specify whether
#' to treat morning hours (e.g., 1 AM) as late (25 H), e.g., for specifying late
#' bedtimes
#'
#' @param hours The vector of times in hours.
#' @param ampm Vector indicating whether given times are AM or PM.
#' @param am Value indicating AM in \code{ampm} variable.
#' @param pm Value indicating PM in \code{ampm} variable.
#' @param treatMorningAsLate \code{TRUE} or \code{FALSE} indicating whether to
#' treat morning times as late (e.g., 1 AM would be considered a late bedtime,
#' i.e., 25 hours, not an early bedtime).
#'
#' @return
#' Hours in 24-hour-time.
#'
#' @family times
#' @family conversion
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' df1 <- data.frame(hours = c(1, 1, 12, 12), ampm = c(0, 0, 1, 1))
#' df2 <- data.frame(hours = c(1, 1, 12, 12), ampm = c(1, 1, 0, 0))
#'
#' # Convert AM and PM hours
#' convertHoursAMPM(hours = df1$hours, ampm = df1$ampm)
#' convertHoursAMPM(hours = df1$hours, ampm = df1$ampm,
#'   treatMorningAsLate = TRUE)
#'
#' convertHoursAMPM(hours = df2$hours, ampm = df2$ampm, am = 1, pm = 0)
#' convertHoursAMPM(hours = df2$hours, ampm = df2$ampm, am = 1, pm = 0,
#'   treatMorningAsLate = TRUE)

convertHoursAMPM <- function(hours, ampm, am = 0, pm = 1, treatMorningAsLate = FALSE){
  hoursCorrected <- rep(NA, length(hours))

  if(treatMorningAsLate == TRUE){
    hoursCorrected[which(ampm == am)] <- hours[which(ampm == am)] + 24
    hoursCorrected[which(ampm == am & hours == 12)] <- 24
  } else{
    hoursCorrected[which(ampm == am)] <- hours[which(ampm == am)]
  }
  hoursCorrected[which(ampm == pm)] <- hours[which(ampm == pm)] + 12
  hoursCorrected[which(ampm == pm & hours == 12)] <- 12

  return(hoursCorrected)
}
