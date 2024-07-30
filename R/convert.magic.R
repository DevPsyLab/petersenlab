#' @title
#' Convert Variable Types.
#'
#' @description
#' Converts variable types of multiple columns of a dataframe at once.
#'
#' @details
#' Converts variable types of multiple columns of a dataframe at once. Convert
#' variable types to character, numeric, or factor.
#'
#' @param obj name of dataframe (object)
#' @param type type to convert variables to one of:
#' \itemize{
#'   \item \code{"character"}
#'   \item \code{"numeric"}
#'   \item \code{"factor"}
#' }
#'
#' @return
#' Dataframe with columns converted to a particular type.
#'
#' @family dataManipulation
#' @family conversion
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' data("USArrests")
#'
#' # Convert variables to character
#' convert.magic(USArrests, "character")
#'
#' @seealso
#' \url{https://stackoverflow.com/questions/11261399/function-for-converting-dataframe-column-type/11263399#11263399}

convert.magic <- function(obj, type){
  FUN1 <- switch(type,
                 character = as.character,
                 numeric = as.numeric,
                 factor = as.factor)
  out <- lapply(obj, function(x) FUN1(as.character(x)))
  as.data.frame(out)
}
