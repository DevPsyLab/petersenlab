#' @title
#' Clean Up Player Names For Merging.
#'
#' @description
#' Cleans up names of players for merging.
#'
#' @details
#' Cleans up names of NFL Football players, including making them all-caps,
#' removing common suffixes, punctuation, spaces, etc. This is helpful for
#' merging multiple datasets.
#'
#' @param name character vector of player names.
#'
#' @return Vector of cleaned player names.
#'
#' @family fantasyFootball
#'
#' @export
#'
#' @examples
#' oldNames <- c("Peyton Manning","Tom Brady","Marvin Harrison Jr.")
#' cleanNames <- cleanUpNames(oldNames)
#' cleanNames

cleanUpNames <- function(name){
  newName <- name |>
    toupper() |>
    gsub(
      pattern = "\\s+(DEFENSE|JR|SR|[IV]+)\\.?$",
      replacement = ""
    ) |>
    gsub(
      pattern = "[[:punct:]]+|\\s+",
      replacement = ""
    )

  return(newName)
}
