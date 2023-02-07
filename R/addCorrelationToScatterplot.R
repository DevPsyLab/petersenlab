#' @title
#' Add Correlation to Scatterplot.
#'
#' @description
#' Add correlation text to scatterplot.
#'
#' @details
#' Adds a correlation coefficient and associated p-value to a scatterplot.
#'
#' @param x vector of the variable for the x-axis.
#' @param y vector of the variable for the y-axis.
#' @param xcoord x-coordinate for the location of the text.
#' @param ycoord y-coordinate for the location of the text.
#' @param size size of the text font.
#' @param col color of the text font.
#' @param method method for calculating the association. One of:
#' \itemize{
#'   \item \code{"pearson"} = Pearson product moment correlation coefficient
#'   \item \code{"spearman"} = Spearman's rho
#'   \item \code{"kendall"} = Kendall's tau
#' }
#'
#' @return
#' Correlation coefficient, degrees of freedom, and p-value printed on
#' scatterplot.
#'
#' @family plot
#' @family correlations
#'
#' @importFrom graphics text
#' @importFrom stats na.omit median cor.test
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' data("USArrests")
#'
#' # Scatterplot
#' plot(USArrests$Assault, USArrests$Murder)
#' addText(x = USArrests$Assault, y = USArrests$Murder)

addText <- function(x, y, xcoord = NULL, ycoord = NULL, size = 1.0, col = NULL, method = "pearson"){
  pValuePlot <- function(value, digits = 3){
    if(value < .001){
      newValue <- " < .001"
    } else {
      newValue <- paste(
        " = ",
        suppressLeadingZero(specify_decimal(value, digits)),
        sep = "")
    }
    return(newValue)
  }

  if(is.null(xcoord) == TRUE){
    xcoord <- median(na.omit(cbind(x,y))[,1])
  }

  if(is.null(ycoord) == TRUE){
    ycoord <- ((
      max(na.omit(cbind(x,y))[,2]) - median(na.omit(cbind(x,y))[,2]))/2) +
      median(na.omit(cbind(x,y))[,2])
  }

  if(method == "pearson"){
    text(
      xcoord,
      ycoord,
      substitute(
        paste(
          italic(r), "(", valueDF, ")",  " = ", valueR,
          ", ", italic(p), valueP,
          sep = ""),
        list(
          valueR = sub("0.", ".", sprintf("%.2f", round(cor.test(x,y, method = method)$estimate[[1]],2))),
          valueDF = cor.test(x,y, method = "pearson")$parameter[[1]],
          valueP = pValuePlot(cor.test(x,y, method = method)$p.value[[1]])
          )
        ),
      col = col,
      cex = size,
      family = "serif" #remove to make text smaller
    )
  } else if(method == "spearman"){
    text(
      xcoord,
      ycoord,
      substitute(
        paste(
          italic(r[s]), "(", valueDF, ")",  " = ", valueR,
          ", ", italic(p), valueP,
          sep = ""),
        list(
          valueR = sub("0.", ".", sprintf("%.2f", round(cor.test(x, y, method = method)$estimate[[1]],2))),
          valueDF = cor.test(x,y, method = "pearson")$parameter[[1]],
          valueP = pValuePlot(cor.test(x,y, method = method)$p.value[[1]])
          )
        ),
      col = col,
      cex = size,
      family = "serif" #remove to make text smaller
    )
  }
  }
