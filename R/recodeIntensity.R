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
#' @param did_not_occur Whether or not the behavior did NOT occur. If \code{0},
#' the behavior did occur (in the given timeframe). If \code{1}, the behavior
#' did not occur in (in the given timeframe).
#' @param frequency The frequency of the behavior.
#' @param item_names The names of the questionnaire items.
#' @param data The data object.
#' @param frequency_vars The name(s) of the variables corresponding to the
#' number of occurrences (\code{num_occurrences}).
#' @param did_not_occur_vars The name(s) of the variables corresponding to
#' whether the behavior did not occur in the past year (\code{did_not_occur}).
#'
#' @return
#' The intensity of the behavior.
#'
#' @family behaviorIntensity

#' @rdname recodeBehaviorIntensity
#' @export
recode_intensity <- function(intensity, did_not_occur = NULL, frequency = NULL){
  if(missing(frequency) | is.null(frequency)){
    result <- ifelse(is.na(did_not_occur), intensity, ifelse(did_not_occur == 1, 0, intensity))
  } else if(missing(did_not_occur) | is.null(did_not_occur)){
    result <- ifelse(is.na(frequency), intensity, ifelse(frequency == 0, 0, intensity))
  } else(
    result <- ifelse(did_not_occur == 1, 0, ifelse(frequency == 0, 0, intensity))
  )

  return(result)
}

#' @rdname recodeBehaviorIntensity
#' @export
mark_intensity_as_zero <- function(item_names, data, did_not_occur_vars = NULL, frequency_vars = NULL) {
  if(missing(frequency_vars) | is.null(frequency_vars)){

    recoded <- Map(
      recode_intensity,
      intensity = data[, item_names],
      did_not_occur = data[, did_not_occur_vars])

  } else if(missing(did_not_occur_vars) | is.null(did_not_occur_vars)){

    recoded <- Map(
      recode_intensity,
      intensity = data[, item_names],
      frequency = data[, frequency_vars])

  } else {

    recoded <- Map(
      recode_intensity,
      intensity = data[, item_names],
      did_not_occur = data[, did_not_occur_vars],
      frequency = data[, frequency_vars])

  }

  result <- as.data.frame(recoded)

  return(result)
}
