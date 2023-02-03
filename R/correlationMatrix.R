#' @title
#' Correlation Matrix.
#'
#' @description
#' Function that creates a correlation matrix similar to SPSS output.
#'
#' @details
#' Co-created by Angela Staples (astaples@emich.edu) and Isaac Petersen
#' (isaac-t-petersen@uiowa.edu). For a partial correlation matrix, see
#' \link{partialcor.table}.
#'
#' @param x Variable or set of variables in the form of a vector or dataframe
#' to correlate with \code{y} (if \code{y} is specified) in an any asymmetric
#' correlation matrix or with itself in a symmetric correlation matrix (if
#' \code{y} is not specified).
#' @param y (optional) Variable or set of variables in the form of a vector or
#' dataframe to correlate with \code{x}.
#' @param type Type of correlation matrix to print. One of:
#' \itemize{
#'   \item \code{"none"} = correlation matrix with \emph{r}, \emph{n},
#'   \emph{p}-values
#'   \item \code{"latex"} = generates latex code for correlation matrix with only
#'   \emph{r}-values
#'   \item \code{"latexSPSS"} = generates latex code for full SPSS-style
#'   correlation matrix
#'   \item \code{"manuscript"} = only \emph{r}-values, 2 digits; works with
#'   \code{x} only (cannot enter variables for \code{y})
#'   \item \code{"manuscriptBig"} = only \emph{r}-values, 2 digits, no asterisks;
#'   works with \code{x} only (cannot enter variables for \code{y})
#'   \item \code{"manuscriptLatex"} = generates latex code for: only
#'   \emph{r}-values, 2 digits; works with \code{x} only (cannot enter variables
#'   for \code{y})
#'   \item \code{"manuscriptBigLatex"} = generates latex code for: only
#'   \emph{r}-values, 2 digits, no asterisks; works with \code{x} only (cannot
#'   enter variables for \code{x})
#' }
#' @param dig Number of decimals to print.
#' @param correlation Method for calculating the association. One of:
#' \itemize{
#'   \item \code{"pearson"} = Pearson product moment correlation coefficient
#'   \item \code{"spearman"} = Spearman's rho
#'   \item \code{"kendall"} = Kendall's tau
#' }
#'
#' @return A correlation matrix.
#'
#' @family correlations
#'
#' @importFrom Hmisc rcorr
#' @importFrom stringr str_trim
#' @importFrom xtable xtable
#' @importFrom stats na.omit
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' data("mtcars")
#'
#' # Correlation Matrix
#' cor.table(mtcars[,c("mpg","cyl","disp")])
#' cor.table(mtcars[,c("mpg","cyl","disp")])
#' cor.table(mtcars[,c("mpg","cyl","disp")], dig = 3)
#' cor.table(mtcars[,c("mpg","cyl","disp")], dig = 3, correlation = "spearman")
#'
#' cor.table(mtcars[,c("mpg","cyl","disp")], type = "manuscript", dig = 3)
#' cor.table(mtcars[,c("mpg","cyl","disp")], type = "manuscriptBig")
#'
#' table1 <- cor.table(mtcars[,c("mpg","cyl","disp")], type = "latex")
#' table2 <- cor.table(mtcars[,c("mpg","cyl","disp")], type = "latexSPSS")
#' table3 <- cor.table(mtcars[,c("mpg","cyl","disp")], type = "manuscriptLatex")
#' table4 <- cor.table(mtcars[,c("mpg","cyl","disp")], type = "manuscriptBigLatex")
#'
#' cor.table(mtcars[,c("mpg","cyl","disp")], mtcars[,c("drat","qsec")])
#' cor.table(mtcars[,c("mpg","cyl","disp")], mtcars[,c("drat","qsec")], type = "manuscript", dig = 3)

cor.table <- function(x, y, type = "none", dig = 2, correlation = "pearson"){
  if(missing(y)){
    x <- as.matrix(x)
    cor.r <- tryCatch(rcorr(as.matrix(x), type = correlation)$r, error=function(e) NULL)
    cor.p <- tryCatch(rcorr(as.matrix(x), type = correlation)$P, error=function(e) NULL)
    cor.n <- tryCatch(rcorr(as.matrix(x), type = correlation)$n, error=function(e) NULL)

    #Rescale N for diagonal (within-variable correlation) to be number of non-NA observations on variable
    for(i in 1:length(diag(cor.n))){
      diag(cor.n)[i] <- length(na.omit(x[,i]))
    }

    r_rows <- 1:dim(cor.r)[1]*3 - 2
    p_rows <- 1:dim(cor.r)[1]*3 - 1
    n_rows <- 1:dim(cor.r)[1]*3
    r.table <- matrix(NA, nrow = 3*dim(cor.r)[1], ncol = dim(cor.r)[2])
    for (i in 1:dim(cor.r)[1]){
      r.table[r_rows[i],] <- str_trim(format(round(cor.r[i,], digits = dig), nsmall = dig))
      r.table[p_rows[i],] <- str_trim(format(round(cor.p[i,], digits = dig), nsmall = dig))
      r.table[n_rows[i],] <- str_trim(round(cor.n[i,], digits = 0))
    }

    r.manuscript <- matrix(NA, nrow = dim(cor.r)[1], ncol = dim(cor.r)[2])
    r.manuscriptBig <- matrix(NA, nrow = dim(cor.r)[1], ncol = dim(cor.r)[2])
    for(i in 1:length(r_rows)){
      r.manuscript[i,] <- str_trim(format(round(cor.r[i,], digits = dig)))
      r.manuscriptBig[i,] <- str_trim(format(round(cor.r[i,], digits = dig)))
    }

    if(length(colnames(x)) == 0) {colnames(x) <- paste("var",1:dim(x)[2], sep = "")} else
      colnames(x) <- colnames(x)
    rownames(r.table) <- rep(paste("var", 1:length(colnames(x)), sep = ""), each = 3)
    rownames(r.manuscript) <- paste("var", 1:length(colnames(x)), sep = "")
    rownames(r.manuscriptBig) <- paste("var", 1:length(colnames(x)), sep = "")
    for(i in 1:length(colnames(x))){
      rownames(r.table)[i*3-2] <- paste(i*3-2, ". ", colnames(x)[i], ".r", sep = "")
      rownames(r.table)[i*3-1] <- paste(i*3-1, ". sig", sep = "")
      rownames(r.table)[i*3] <-   paste(i*3, ". n", sep = "")
      rownames(r.manuscript)[i] <- paste(i, ". ", colnames(x)[i], sep = "")
      rownames(r.manuscriptBig)[i] <- paste(i, ". ", colnames(x)[i], sep = "")
    }
    colnames(r.table) <- colnames(x)
    colnames(r.manuscript) <- colnames(x)
    colnames(r.manuscriptBig) <- colnames(x)

    #Suppress leading zero
    for(i in c(r_rows, p_rows)){
      for(j in 1:ncol(r.table)){
        r.table[i,j] <- suppressWarnings(suppressLeadingZero(specify_decimal(as.numeric(r.table[i,j]), k = dig)))
      }
    }

    for(i in 1:length(p_rows)) {
      for(j in 1:length(p_rows)) {
        r.manuscript[i,j] <- suppressLeadingZero(specify_decimal(as.numeric(r.manuscript[i,j]), dig))
        r.manuscriptBig[i,j] <- suppressLeadingZero(specify_decimal(as.numeric(r.manuscriptBig[i,j]), dig))
      }
    }

    #The following section bolds (in latex) significant p-values:
    for(i in 1:length(p_rows)) {
      for(j in 1:length(p_rows)) {
        if(type=="manuscriptBigLatex" & i != j){
          if (r.table[(3*i)-1,j] <= .05 & is.na(r.table[(3*i)-1,j]) == FALSE) {
            r.manuscriptBig[i,j] <- paste("$$\\bm{", r.manuscriptBig[i,j],"}$$", sep = "")
          } else {
            r.manuscriptBig[i,j] <- paste("$$", r.manuscriptBig[i,j],"$$", sep = "")
          }
        }
      }
    }

    #The following section marks significant (*,**,***) and marginally significant (~) p-values.
    for(i in 1:length(p_rows)) {
      for(j in 1:length(p_rows)) {
        pVal <- suppressWarnings(as.numeric(r.table[(3*i) - 1,j]))
        if(type=="manuscriptLatex"){
          if (pVal <= .1 & pVal >= .05 & is.na(pVal) == FALSE) {
            r.manuscript[i,j] <- paste(r.manuscript[i,j],"^{\\dagger}", sep = "")
          } else {
          }
          if (pVal < .05 & pVal >= .01 & is.na(pVal) == FALSE) {
            r.manuscript[i,j] <- paste(r.manuscript[i,j],"^{*}", sep = "")
          } else {
          }
          if (pVal < .01 & pVal >= .001 & is.na(pVal) == FALSE) {
            r.manuscript[i,j] <- paste(r.manuscript[i,j],"^{**}", sep = "")
          } else {
          }
          if (pVal < .001 & pVal >= 0 & is.na(pVal) == FALSE) {
            r.manuscript[i,j] <- paste(r.manuscript[i,j],"^{***}", sep = "")
          } else {
            r.manuscript[i,j] <- paste(r.manuscript[i,j], sep = "")
          }
        } else{
          if (pVal <= .1 & pVal >= .05 & is.na(pVal) == FALSE) {
            r.table[(3*i)-2,j] <- paste(r.table[(3*i)-2,j], "\u2020", sep = "")
            r.manuscript[i,j] <- paste(r.manuscript[i,j], "\u2020", sep = "")
          } else {

          }
          if (pVal < .05 & pVal >= .01 & is.na(pVal) == FALSE) {
            r.table[(3*i)-2,j] <- paste(r.table[(3*i)-2,j], "*", sep = "")
            r.manuscript[i,j] <- paste(r.manuscript[i,j], "*", sep = "")
          } else {
          }
          if (pVal < .01 & pVal >= .001 & is.na(pVal) == FALSE) {
            r.table[(3*i)-2,j] <- paste(r.table[(3*i)-2,j], "**", sep = "")
            r.manuscript[i,j] <- paste(r.manuscript[i,j], "**", sep = "")
          } else {
          }
          if (pVal < .001 & pVal >= 0 & is.na(pVal) == FALSE) {
            r.table[(3*i)-2,j] <- paste(r.table[(3*i)-2,j], "***", sep = "")
            r.manuscript[i,j] <- paste(r.manuscript[i,j], "***", sep = "")
          } else {
          }
        }
      }
    }

    #Removes top half of matrix
    for(i in 1:length(p_rows)){
      for(j in 1:length(p_rows)){
        if(j > i){
          r.manuscript[i,j] <- ""
          r.manuscriptBig[i,j] <- ""
        } else{
        }
      }
    }

    #Changes diagonal to dashes
    if(type == "manuscriptLatex" | type == "manuscriptBigLatex"){
      for(i in 1:length(diag(r.manuscript))){
        diag(r.manuscript)[i] <- "\\multicolumn{1}{c}{$-$}" #"-" #"$-$"
        diag(r.manuscriptBig)[i] <- "\\multicolumn{1}{c}{$-$}" #"-" #"$-$"
      }
    }

    #Convert NAs to dashes
    if(type == "manuscriptLatex" | type == "manuscriptBigLatex"){
      r.table[r.table == "NA" | r.table == "NaN"] <- "\\multicolumn{1}{c}{$-$}"
      r.manuscript[r.manuscript == "NA" | r.manuscript == "NaN"] <- "\\multicolumn{1}{c}{$-$}"
      r.manuscriptBig[r.manuscriptBig == "NA" | r.manuscriptBig == "NaN"] <- "\\multicolumn{1}{c}{$-$}"
    }

  } else { #If y exists
    if (is.null(dim(x)) == FALSE) {
      lenx <- dim(x)[2]
    } else {
      lenx <- 1
    }
    if (is.null(dim(y)) == FALSE) {
      leny <- dim(y)[2]
    } else {
      leny <- 1
    }

    xWithy <- as.matrix(cbind(x,y))
    #continues even if error bc pair of variables has n=0 -> returns NAs
    cor.r <- tryCatch(rcorr(as.matrix(xWithy), type = correlation)$r, error=function(e) NULL)
    cor.p <- tryCatch(rcorr(as.matrix(xWithy), type = correlation)$P, error=function(e) NULL)
    cor.n <- tryCatch(rcorr(as.matrix(xWithy), type = correlation)$n, error=function(e) NULL)
    r_rows <- 1:dim(cor.r)[1]*3-2
    p_rows <- 1:dim(cor.r)[1]*3-1
    n_rows <- 1:dim(cor.r)[1]*3
    r.table <- matrix(NA,nrow=3*dim(cor.r)[1],ncol=dim(cor.r)[2])
    for (i in 1:dim(cor.r)[1]){
      r.table[r_rows[i],] <- str_trim(format(round(cor.r[i,], digits = dig), nsmall = dig))
      r.table[p_rows[i],] <- str_trim(format(round(cor.p[i,], digits = dig), nsmall = dig))
      r.table[n_rows[i],] <- round(cor.n[i,], digits = 0)
    }

    r.manuscript <- matrix(NA, nrow = dim(cor.r)[1], ncol = dim(cor.r)[2])
    r.manuscriptBig <- matrix(NA, nrow = dim(cor.r)[1], ncol = dim(cor.r)[2])
    for(i in 1:length(r_rows)){
      r.manuscript[i,] <- str_trim(format(round(cor.r[i,], digits = dig), nsmall = dig))
      r.manuscriptBig[i,] <- str_trim(format(round(cor.r[i,], digits = dig), nsmall = dig))
    }

    if (length(colnames(xWithy))==0) {
      colnames(xWithy) <- paste("var",1:dim(xWithy)[2], sep = "")
    } else {
      y <- y
    }
    colnames(xWithy) <- colnames(xWithy)
    rownames(r.table) <- rep(paste("var",1:length(colnames(xWithy)), sep = ""),each=3)
    rownames(r.manuscript) <- paste("var",1:length(colnames(xWithy)), sep = "")
    rownames(r.manuscriptBig) <- paste("var",1:length(colnames(xWithy)), sep = "")
    for(i in 1:length(colnames(xWithy))){
      rownames(r.table)[i*3-2] <- paste(i*3-2, ". ", colnames(x)[i], ".r", sep = "")
      rownames(r.table)[i*3-1] <- paste(i*3-1, ". sig", sep = "")
      rownames(r.table)[i*3] <-   paste(i*3, ". n", sep = "")
      rownames(r.manuscript)[i] <- paste(i, ". ", colnames(x)[i], sep = "")
      rownames(r.manuscriptBig)[i] <- paste(i, ". ", colnames(x)[i], sep = "")
    }
    colnames(r.table) <- colnames(xWithy)
    colnames(r.manuscript) <- colnames(xWithy)
    colnames(r.manuscriptBig) <- colnames(xWithy)

    #Suppress leading zero
    for(i in c(r_rows, p_rows)){
      for(j in 1:ncol(r.table)){
        r.table[i,j] <- suppressLeadingZero(r.table[i,j])
      }
    }

    for(i in 1:length(p_rows)) {
      for(j in 1:length(p_rows)) {
        r.manuscript[i,j] <- suppressLeadingZero(specify_decimal(as.numeric(r.manuscript[i,j]), dig))
        r.manuscriptBig[i,j] <- suppressLeadingZero(specify_decimal(as.numeric(r.manuscriptBig[i,j]), dig))
      }
    }

    #The following section bolds (in latex) significant p-values:
    for(i in 1:length(p_rows)) {
      for(j in 1:length(p_rows)) {
        if(type=="manuscriptBigLatex" & i != j){
          if (r.table[(3*i)-1,j] <= .05 & is.na(r.table[(3*i)-1,j]) == FALSE) {
            r.manuscriptBig[i,j] <- paste("$$\\bm{", r.manuscriptBig[i,j],"}$$", sep = "")
          } else {
            r.manuscriptBig[i,j] <- paste("$$", r.manuscriptBig[i,j],"$$", sep = "")
          }
        }
      }
    }

    #The following section marks significant (*,**,***) and marginally significant (~) p-values.
    for(i in 1:length(p_rows)) {
      for(j in 1:length(p_rows)) {
        pVal <- suppressWarnings(as.numeric(r.table[(3*i) - 1,j]))
        if(type=="manuscriptLatex"){
          if (pVal <= .1 & pVal >= .05 & is.na(pVal) == FALSE) {
            r.manuscript[i,j] <- paste(r.manuscript[i,j],"^{\\dagger}", sep = "")
          } else {
          }
          if (pVal < .05 & pVal >= .01 & is.na(pVal) == FALSE) {
            r.manuscript[i,j] <- paste(r.manuscript[i,j],"^{*}", sep = "")
          } else {
          }
          if (pVal < .01 & pVal >= .001 & is.na(pVal) == FALSE) {
            r.manuscript[i,j] <- paste(r.manuscript[i,j],"^{**}", sep = "")
          } else {
          }
          if (pVal < .001 & pVal >= 0 & is.na(pVal) == FALSE) {
            r.manuscript[i,j] <- paste(r.manuscript[i,j],"^{***}", sep = "")
          } else {
            r.manuscript[i,j] <- paste(r.manuscript[i,j], sep = "")
          }
        } else{
          if (pVal <= .1 & pVal >= .05 & is.na(pVal) == FALSE) {
            r.table[(3*i)-2,j] <- paste(r.table[(3*i)-2,j],"\u2020", sep = "")
            r.manuscript[i,j] <- paste(r.manuscript[i,j], "\u2020", sep = "")
          } else {
          }
          if (pVal < .05 & pVal >= .01 & is.na(pVal) == FALSE) {
            r.table[(3*i)-2,j] <- paste(r.table[(3*i)-2,j],"*", sep = "")
            r.manuscript[i,j] <- paste(r.manuscript[i,j], "*", sep = "")
          } else {
          }
          if (pVal < .01 & pVal >= .001 & is.na(pVal) == FALSE) {
            r.table[(3*i)-2,j] <- paste(r.table[(3*i)-2,j],"**", sep = "")
            r.manuscript[i,j] <- paste(r.manuscript[i,j], "**", sep = "")
          } else {
          }
          if (pVal < .001 & pVal >= 0 & is.na(pVal) == FALSE) {
            r.table[(3*i)-2,j] <- paste(r.table[(3*i)-2,j],"***", sep = "")
            r.manuscript[i,j] <- paste(r.manuscript[i,j], "***", sep = "")
          } else {
          }
        }
      }
    }
    r.table <- as.matrix(r.table[1:(lenx*3), lenx+1:leny])
    r.manuscript <- as.matrix(r.manuscript[1:lenx, lenx+1:leny])
    r.manuscriptBig <- as.matrix(r.manuscriptBig[1:lenx, lenx+1:leny])

    #Convert NAs to dashes
    if(type == "manuscriptLatex" | type == "manuscriptBigLatex"){
      r.table[r.table == "NA" | r.table == "NaN"] <- "\\multicolumn{1}{c}{$-$}"
      r.manuscript[r.manuscript == "NA" | r.manuscript == "NaN"] <- "\\multicolumn{1}{c}{$-$}"
      r.manuscriptBig[r.manuscriptBig == "NA" | r.manuscriptBig == "NaN"] <- "\\multicolumn{1}{c}{$-$}"
    }
  }

  r.table <- data.frame(r.table)
  r.manuscript <- data.frame(r.manuscript)
  r.manuscriptBig <- data.frame(r.manuscriptBig)

  if(missing(type)){
    print(r.table, quote = FALSE)
    returnTable <- r.table
  } else if(type=="none"){
    print(r.table, quote = FALSE)
    returnTable <- r.table
  } else if(type=="latexSPSS"){
    print(r.table, quote = FALSE)
    returnTable <- r.table
  } else if (type=="latex"){
    print(r.table, quote = FALSE)
    xtable(r.table[1:(dim(r.table)[1]/3)*3-2,])
    returnTable <- xtable(r.table[1:(dim(r.table)[1]/3)*3-2,])
  } else if (type=="manuscript"){
    print(r.manuscript, quote = FALSE)
    returnTable <- r.manuscript
  } else if (type=="manuscriptBig"){
    print(r.manuscriptBig, quote = FALSE)
    returnTable <- r.manuscriptBig
  } else if(type=="manuscriptLatex"){
    #print(r.manuscript, quote = FALSE)
    returnTable <- r.manuscript
  } else if(type=="manuscriptBigLatex"){
    #print(r.manuscriptBig, quote = FALSE)
    returnTable <- r.manuscriptBig
  }
}
