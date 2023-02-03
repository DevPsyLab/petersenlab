#' @title
#' Person Months.
#'
#' @description
#' Calculate perons months for personnel effort in grants.
#'
#' @details
#' Calculate person months for personnel effort in grant proposals from academic
#' months, calendar months, and summer months.
#'
#' @param academicMonths The number of academic months.
#' @param calendarMonths The number of calendar months.
#' @param summerMonths The number of summer months.
#' @param appointment The duration (in months) of one's annual appointment;
#' used as the denominator for determining the timeframe out of which the academic months occur.
#' Default is a 9-month appointment.
#' @param effortAcademic Percent effort (in proportion) during academic months.
#' @param effortCalendar Percent effort (in proportion) during calendar months.
#' @param effortSummer Percent effort (in proportion) during summer months.
#'
#' @return
#' The person months of effort.
#'
#' @family grants
#'
#' @examples
#' # Specify Values
#' appointmentDuration <- 9 #(in months)
#'
#' # Specify either Set 1 (months) or Set 2 (percent effort) below:
#'
#' #Set 1: Months
#' academicMonths <- 1.3 #AY (academic year) months (should be between 0 to appointmentDuration)
#' calendarMonths <- 0 #CY (calendar year) months (should be between 0-12)
#' summerMonths <- 0.5 #SM (summer) months (should be between 0 to [12-appointmentDuration])
#'
#' # Set 2: Percent Effort
#' percentEffortAcademic <- 0.1444444 #(a proportion; should be between 0-1)
#' percentEffortCalendar <- 0 #(a proportion; should be between 0-1)
#' percentEffortSummer <- 0.1666667 #(a proportion; should be between 0-1)
#'
#' # Calculations
#' summerDuration <- 12 - appointmentDuration
#'
#' # Percent effort (in proportion)
#' percentEffort(academicMonths = academicMonths)
#' percentEffort(calendarMonths = calendarMonths)
#' percentEffort(summerMonths = summerMonths)
#'
#' # Person-Months From NIH Website
#' (percentEffort(academicMonths = academicMonths) * appointmentDuration) +
#'  (percentEffort(calendarMonths = calendarMonths) * 12) +
#'  (percentEffort(summerMonths = summerMonths) * summerDuration)
#'
#' # Person-Months from Academic/Calendar/Summer Months
#' personMonths(academicMonths = academicMonths,
#'              calendarMonths = calendarMonths,
#'              summerMonths = summerMonths)
#'
#' # Person-Months from Percent Effort
#' personMonths(effortAcademic = percentEffortAcademic,
#'              effortCalendar = percentEffortCalendar,
#'              effortSummer = percentEffortSummer)
#'
#' @seealso
#' \url{https://nexus.od.nih.gov/all/2015/05/27/how-do-you-convert-percent-effort-into-person-months}

#' @rdname personMonths
#' @export
percentEffort <- function(academicMonths = NULL, calendarMonths = NULL, summerMonths = NULL, appointment = 9){
  if(!is.null(academicMonths)){
    percentEffort <- academicMonths / appointment
  } else if(!is.null(calendarMonths)){
    percentEffort <- calendarMonths/12
  } else{
    summerDuration <- 12 - appointment
    percentEffort <- summerMonths / summerDuration
  }

  return(percentEffort)
}

#' @rdname personMonths
#' @export
personMonths <- function(academicMonths = NULL, calendarMonths = NULL, summerMonths = NULL,
                         effortAcademic = NULL, effortCalendar = NULL, effortSummer = NULL,
                         appointment = 9){
  if(!is.null(academicMonths) | !is.null(calendarMonths) | !is.null(summerMonths)){
    personMonths <- sum(c(academicMonths, calendarMonths, summerMonths), na.rm = TRUE)
  } else{
    summerDuration <- 12 - appointment
    personMonths <- (effortAcademic * appointment) +
      (effortCalendar * 12) +
      (effortSummer * summerDuration)
  }

  return(personMonths)
}
