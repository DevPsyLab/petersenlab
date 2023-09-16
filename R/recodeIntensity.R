#' @title
#' Recode Intensity.
#'
#' @description
#' Recode intensity of behavior based on frequency of behavior.
#'
#' @details
#' Recodes the intensity of behavior to zero if the frequency of the behavior is
#' zero (i.e., if the behavior has not occurred).
#'
#' @param intensity The intensity of the behavior.
#' @param not_in_the_past_year Whether or not the behavior did NOT occur in
#' the past year. If \code{yes}, the behavior did not occur in the past year.
#' @param frequency The frequency of the behavior.
#' @param item_names The names of the questionnaire items.
#' @param data The data object.
#' @param frequency_vars The name(s) of the variables corresponding to the
#' number of occurrences (\code{num_occurrences}).
#' @param not_in_past_year_vars The name(s) of the variables corresponding to
#' whether the behavior did not occur in the past year
#' (\code{not_occurred_past_year}).
#'
#' @return
#' The intensity of the behavior.
#'
#' @family behaviorIntensity

#' @rdname recodeBehaviorIntensity
#' @export
recode_intensity <- function(intensity, not_in_the_past_year = NULL, frequency = NULL){
  if(missing(frequency) | is.null(frequency)){
    result <- ifelse(is.na(not_in_the_past_year), intensity, ifelse(not_in_the_past_year == 1, 0, intensity))
  } else if(missing(not_in_the_past_year) | is.null(not_in_the_past_year)){
    result <- ifelse(is.na(frequency), intensity, ifelse(frequency == 0, 0, intensity))
  }

  return(result)
}

#' @rdname recodeBehaviorIntensity
#' @export
mark_intensity_as_zero <- function(item_names, data, not_in_past_year_vars = NULL, frequency_vars = NULL) {
  if(missing(frequency_vars) | is.null(frequency_vars)){

    recoded <- Map(
      recode_intensity,
      intensity = data[, item_names],
      not_in_the_past_year = data[, not_in_past_year_vars])

  } else if(missing(not_in_past_year_vars) | is.null(not_in_past_year_vars)){

    recoded <- Map(
      recode_intensity,
      intensity = data[, item_names],
      frequency = data[, frequency_vars])

  }

  result <- as.data.frame(recoded)

  return(result)
}
