#' @title
#' Frequency Per Duration.
#'
#' @description
#' Estimate frequency of a behavior for a particular duration.
#'
#' @details
#' Estimates the frequency of a given behavior for a particular duration, given
#' a specified number of times it occurred during a specified interval.
#'
#' @param num_occurrences The number of times the behavior occurred during the
#' specified interval, \code{interval}.
#' @param interval The specified interval corresponding to the number of times
#' the behavior occurred \code{num_occurrences}.
#' @param duration The desired duration during which to estimate how many times
#' the behavior occurred:
#' \itemize{
#'   \item \code{1} = average number of times per day
#'   \item \code{2} = average number of times per week
#'   \item \code{3} = number of times in the past month
#'   \item \code{4} = number of times in the past year
#' }
#' @param not_occurred_past_year Whether or not the behavior did NOT occur in
#' the past year. If \code{yes}, the behavior did not occur in the past year.
#' @param item_names The names of the questionnaire items.
#' @param data The data object.
#' @param frequency_vars The name(s) of the variables corresponding to the
#' number of occurrences (\code{num_occurrences}).
#' @param interval_vars The name(s) of the variables corresponding to the
#' intervals (\code{interval}).
#' @param not_in_past_year_vars The name(s) of the variables corresponding to
#' whether the behavior did not occur in the past year
#' (\code{not_occurred_past_year}).
#'
#' @return
#' The frequency of the behavior for the specified duration.
#'
#' @family behaviorFrequency
#'
#' @examples
#' timesPerInterval(
#'   num_occurrences = 2,
#'   interval = 3,
#'   duration = "month",
#'   not_occurred_past_year = 0
#' )

#' @rdname frequencyPerDuration
#' @export
timesPerInterval <- function(num_occurrences, interval, duration = "month", not_occurred_past_year) {
  valid_intervals <- c(1, 2, 3, 4)

  ifelse_valid <- function(condition, yes, no) {
    ifelse(is.na(condition) | !condition, no, yes)
  }

  interval_days <- ifelse_valid(
    interval == 1, 1,
    ifelse_valid(interval == 2, 7, ifelse_valid(interval == 3, 30, ifelse_valid(interval == 4, 365, NA)))
  )

  duration_days <- switch(
    duration,
    "day" = 1,
    "week" = 7,
    "month" = 30,
    "year" = 365
  )

  interval_occurrences <- ifelse(
    (is.na(num_occurrences) | is.na(interval)) & not_occurred_past_year == 0,
    NA,
    ifelse(not_occurred_past_year == 1, 0, num_occurrences * (duration_days / interval_days))
  )

  return(interval_occurrences)
}

#' @rdname frequencyPerDuration
#' @export
computeItemFrequencies <- function(item_names, data, duration = "month", frequency_vars, interval_vars, not_in_past_year_vars) {
  # Define a function to apply to each item
  processItem <- function(item_name, data, duration, frequency_var, interval_var, not_in_past_year_var) {
    results <- timesPerInterval(
      num_occurrences = data[[frequency_var]],
      interval = data[[interval_var]],
      duration,
      not_occurred_past_year = data[[not_in_past_year_var]]
    )

    return(results)
  }

  # Use mapply to apply the processItem function to each item
  results_list <- mapply(
    processItem,
    item_name = item_names,
    duration,
    data = list(data), # wrap data in a list
    frequency_var = frequency_vars,
    interval_var = interval_vars,
    not_in_past_year_var = not_in_past_year_vars)

  # Convert the list of results into a dataframe
  results_df <- as.data.frame(results_list)

  # Rename columns based on item names
  colnames(results_df) <- item_names

  return(results_df)
}
