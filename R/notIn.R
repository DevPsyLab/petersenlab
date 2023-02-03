#' @title
#' NOTIN Operator.
#'
#' @description
#' NOTIN operator.
#'
#' @details
#' Determine whether values in one vector are not in another vector.
#'
#' @param x vector or \code{NULL}: the values to be matched. Long vectors are
#' supported.
#' @param table vector or \code{NULL}: the values to be matched against. Long
#' vectors are supported.
#'
#' @return Vector of \code{TRUE} and \code{FALSE}, indicating whether values in
#' one vector are not in another vector.
#'
#' @family operators
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' v1 <- c("Sally","Tom","Barry","Alice")
#' listToCheckAgainst <- c("Tom","Alice")
#'
#' v1 %ni% listToCheckAgainst
#' v1[v1 %ni% listToCheckAgainst]
#'
#' @seealso
#' \url{https://www.r-bloggers.com/2018/07/the-notin-operator/}
#' \url{https://stackoverflow.com/questions/71309487/r-package-documentation-undocumented-arguments-in-documentation-object-for-a?noredirect=1}

`%ni%` <- function(x, table) {!(x %in% table)}
