#' @title
#' Sorts loadings from exploratory factor analysis.
#'
#' @description
#' Sorts items' loadings based on their loadings from exploratoary factor
#' analysis fit with the \code{psych::fa()} function.
#'
#' @details
#' Adapted from code by Philipp Doebler (doebler@statistik.tu-dortmund.de).
#'
#' @param fit the fitted object from the \code{psych::fa()} function
#' @param sort_type how to sort the loadings. One of:
#' \itemize{
#'   \item "largest_loading": sorts items by the largest loading
#'   \item "largest_loading_but_first": sorts items by the largest loading, ignoring the loading on the first factor
#'   \item "first": sorts items by the largest loading on the first factor
#' }
#' @param nchar the limit for the number of characters to display for the item
#' label
#' @param return_blocks whether to return the block number that corresponds to
#' each item
#' @param showlatentcor whether or not to print the intercorrelation among the
#' latent factors (only possible for models with an oblique rotation)
#' @param itemLabels a vector of the item labels
#'
#' @return
#' Sorted loadings from exploratory factor analysis model.
#'
#' @family factor analysis
#'
#' @importFrom stats loadings
#'
#' @export

my_loadings_sorter <- function(fit,
                               sort_type = "largest_loading",
                               nchar = 40,
                               return_blocks = FALSE,
                               showlatentcor = TRUE,
                               itemLabels = NULL){
  my_loadings <- loadings(fit)

  if(sort_type == "largest_loading"){
    blocks <- apply(abs(my_loadings), 1, which.max) # find the largest loading
    largest_within_blocks <- my_loadings[cbind(1:nrow(my_loadings), blocks)]
    my_order <- order(-blocks, abs(largest_within_blocks), decreasing = TRUE)
  } else if(sort_type == "largest_loading_but_first"){
    blocks <- apply(abs(my_loadings[,-1]), 1, which.max) # find the largest loading, ignore first factor
    largest_within_blocks <- my_loadings[cbind(1:nrow(my_loadings), blocks + 1)]
    my_order <- order(-blocks, abs(largest_within_blocks), decreasing = TRUE)
  } else if(sort_type == "first"){
    largest_within_blocks <- my_loadings[cbind(1:nrow(my_loadings), 1)]
    my_order <- order(abs(largest_within_blocks), decreasing = TRUE)
  }

  if(return_blocks){
    return(blocks)
  }

  if(showlatentcor){
    print(round(fit$Phi, 2))
  }

  if(!is.null(itemLabels)){
    attr(my_loadings, "dimnames")[[1]] <- paste(row.names(my_loadings), substr(itemLabels, 1, nchar), sep = " ")
  }

  out <- my_loadings[my_order, ]
  ## add h^2 as a new column
  h2 <- rowSums(out^2)
  out <- cbind(out, h2)
  colnames(out)[ncol(out)] <- "h2"
  class(out) <- "loadings" # hackish

  return(out)
}
