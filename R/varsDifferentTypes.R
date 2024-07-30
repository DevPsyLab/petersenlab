#' @title
#' Identify Variables of Different Types.
#'
#' @description
#' Identifies the variables in common across two dataframes that have different
#' types.
#'
#' @details
#' Identifies the variables that have the same name across two dataframes that
#' have different types, which can pose challenges for merging two dataframes.
#'
#' @param df1 dataframe 1 (object)
#' @param df2 dataframe 2 (object)
#'
#' @return
#' Dataframe with columns for the variable name, the variable type in \code{df1}
#' and the variable type in \code{df2}.
#'
#' @family dataManipulation
#'
#' @importFrom purrr map_chr
#' @importFrom dplyr intersect
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' df1 <- data.frame(
#'   A = 1:3,
#'   B = 2:4,
#'   C = 3:5
#' )
#'
#' df2 <- data.frame(
#'   A = as.character(1:3),
#'   B = 2:4,
#'   C = as.factor(3:5)
#' )
#'
#' # Check if any rows are not NA
#' varsDifferentTypes(df1, df2)

varsDifferentTypes <- function(df1, df2){
  # Get the data types of each column in both datasets
  types_df1 <- df1 |>
    purrr::map_chr(class)

  types_df2 <- df2 |>
    purrr::map_chr(class)

  # Find common columns
  common_cols <- dplyr::intersect(names(types_df1), names(types_df2))

  # Compare data types of common columns
  type_comparison <- data.frame(
    column = common_cols,
    type_df1 = types_df1[common_cols],
    type_df2 = types_df2[common_cols]
  )

  # Filter the results for columns with different types
  different_types <- type_comparison[which(
    type_comparison$type_df1 != type_comparison$type_df2),]

  return(different_types)
}
