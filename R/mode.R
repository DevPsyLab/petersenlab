#' @title
#' Statistical Mode.
#'
#' @description
#' Calculate statistical mode.
#'
#' @details
#' Calculates statistical mode(s).
#'
#' @param x Numerical vector.
#' @param multipleModes How to handle multiple modes. One of:
#' \itemize{
#'   \item \code{"mean"} = if there are multiple modes, take the mean of all
#'   modes
#'   \item \code{"first"} = if there are multiple modes, select the first mode
#'   \item \code{"all"} = if there are multiple modes, return all modes
#' }
#'
#' @return Statistical mode(s).
#'
#' @family computations
#'
#' @importFrom stats na.omit
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' v1 <- c(1, 1, 2, 2, 3)
#'
#' #Calculate Statistical Mode
#' Mode(v1)
#' Mode(v1, multipleModes = "mean")
#' Mode(v1, multipleModes = "first")
#'
#' @seealso
#' \url{https://stackoverflow.com/questions/2547402/how-to-find-the-statistical-mode/8189441#8189441}

Mode <- function(x, multipleModes = "all"){
  ux <- na.omit(unique(x))
  tab <- tabulate(match(x, ux))
  statisticalModes <- ux[tab == max(tab)]

  if(multipleModes == "mean"){
    statisticalMode <- mean(statisticalModes)
  } else if(multipleModes == "first"){
    statisticalMode <- ux[which.max(tabulate(match(x, ux)))]
  } else if(multipleModes == "all"){
    statisticalMode <- statisticalModes
  }

  return(statisticalMode)
}
