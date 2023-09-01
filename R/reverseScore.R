#' @title
#' Reverse Score Variables.
#'
#' @description
#' Reverse score variables using either the theoretical min and max, or the
#' observed max.
#'
#' @details
#' Reverse scores variables using either the theoretical min and max (by
#' subtracting the theoretical maximum from each score and adding the
#' theoretical minimum to each score) or by subtracting each score from the
#' maximum score for that variable.
#'
#' @param data Data object.
#' @param variables Names of variables to reverse score.
#' @param theoretical_max (Optional): the theoretical maximum score.
#' @param theoretical_min (Optional): the theoretical minimum score.
#' @param append_string (Optional): a string to append to each variable name.
#'
#' @return
#' Dataframe with reverse-scored variables.
#'
#' @export
#'
#' @importFrom dplyr mutate across
#' @importFrom tidyselect everything
#'
#' @examples
#' mydata <- data.frame(
#'   var1 = c(1, 2, NA, 4, 5),
#'   var2 = c(NA, 4, 3, 2, 1)
#' )
#'
#' variables_to_reverse_score <- c("var1", "var2")
#'
#' reverse_score(
#'   mydata,
#'   variables = variables_to_reverse_score)
#'
#' reverse_score(
#'   mydata,
#'   variables = variables_to_reverse_score,
#'   append_string = ".R")
#'
#' reverse_score(
#'   mydata,
#'   variables = variables_to_reverse_score,
#'   theoretical_max = 7)
#'
#' reverse_score(
#'   mydata,
#'   variables = variables_to_reverse_score,
#'   theoretical_max = 7,
#'   theoretical_min = 1)

reverse_score <- function(data, variables, theoretical_max = NULL, theoretical_min = NULL, append_string = NULL) {
  mydata <- data[variables]

  if (is.null(theoretical_max) && is.null(theoretical_min)) {
    mydata_reversed <- mydata |>
      mutate(across(everything(), ~ ifelse(!is.na(.), max(., na.rm = TRUE) - ., NA)))
  } else if (is.null(theoretical_min)) {
    mydata_reversed <- mydata |>
      mutate(across(everything(), ~ ifelse(!is.na(.), theoretical_max - ., NA)))
  } else {
    mydata_reversed <- mydata |>
      mutate(across(everything(), ~ ifelse(!is.na(.), theoretical_max + theoretical_min - ., NA)))
  }

  if (!is.null(append_string)) {
    colnames(mydata_reversed) <- paste(colnames(mydata_reversed), append_string, sep = "")
  }

  return(mydata_reversed)
}
