#' @title
#' Adjust Sourdough Recipe Fermentation and Proofing Times Based on Temperature
#'
#' @description
#' Adjust sourdough recipe fermentation and proofing times based on temperature.
#'
#' @details
#' Adjusts sourdough recipe fermentation and proofing times based on ambient
#' temperature. Suggested times are calculated using the \eqn{Q_{10}}
#' temperature coefficient, which describes how the rate of fermentation changes
#' with a 10°C temperature difference.
#'
#' @param original_time The original time(s) specified in the original recipe.
#' @param recipe_temp The intended ambient temperature in the original recipe.
#' @param actual_temp The actual ambient temperature used.
#' @param q10 The \eqn{Q_{10}} temperature coefficient (describes rate change
#' per 10°C).
#' @param temp_unit "F" for Fahrenheit; "C" for Celsius.
#'
#' @return The adjusted sourdough fermentation or proofing time(s).
#'
#' @family baking
#'
#' @export
#'
#' @examples
#' adjust_sourdough_time(
#'   original_time = c(12, 15, 18),
#'   recipe_temp = 70,
#'   actual_temp = 75
#'   )
#'
#' @seealso
#' \url{https://en.wikipedia.org/wiki/Q10_(temperature_coefficient)}

adjust_sourdough_time <- function(
    original_time,
    recipe_temp,
    actual_temp,
    q10 = 2,
    temp_unit = c("F","C")) {

  # Match argument for temperature unit
  temp_unit <- match.arg(temp_unit)

  # Convert to Celsius if input is in Fahrenheit
  if (temp_unit == "F") {
    recipe_temp <- (recipe_temp - 32) * 5 / 9
    actual_temp <- (actual_temp - 32) * 5 / 9
  }

  # Calculate the adjustment factor
  adjustment_factor <- q10 ^ ((recipe_temp - actual_temp) / 10)

  # Return the new time
  new_time <- original_time * adjustment_factor

  return(new_time)
}
