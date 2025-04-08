#' @title
#' Partial Correlation Matrix.
#'
#' @description
#' Function that creates a partial correlation matrix similar to SPSS output.
#'
#' @details
#' Co-created by Angela Staples (astaples@emich.edu) and Isaac Petersen
#' (isaac-t-petersen@uiowa.edu). Creates a partial correlation matrix,
#' controlling for one or more covariates. For a standard correlation matrix,
#' see \link{cor.table}.
#'
#' @param z Covariate(s) to partial out from association.
#'
#' @inheritParams cor.table
#'
#' @return A partial correlation matrix.
#'
#' @family correlations
#'
#' @importFrom Hmisc rcorr
#' @importFrom stringr str_trim
#' @importFrom psych corr.p partial.r
#' @importFrom xtable xtable
#' @importFrom stats na.omit
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' data("mtcars")
#'
#' #Correlation Matrix
#' partialcor.table(mtcars[,c("mpg","cyl","disp")], z = mtcars$hp)
#' partialcor.table(mtcars[,c("mpg","cyl","disp")], z = mtcars[,c("hp","wt")])
#' partialcor.table(mtcars[,c("mpg","cyl","disp")], z = mtcars[,c("hp","wt")],
#'   dig = 3)
#' partialcor.table(mtcars[,c("mpg","cyl","disp")], z = mtcars[,c("hp","wt")],
#'   dig = 3, correlation = "spearman")
#'
#' partialcor.table(mtcars[,c("mpg","cyl","disp")], z = mtcars[,c("hp","wt")],
#'   type = "manuscript", dig = 3)
#' partialcor.table(mtcars[,c("mpg","cyl","disp")], z = mtcars[,c("hp","wt")],
#'   type = "manuscriptBig")
#'
#' table1 <- partialcor.table(mtcars[,c("mpg","cyl","disp")],
#'   z = mtcars[,c("hp","wt")], type = "latex")
#' table2 <- partialcor.table(mtcars[,c("mpg","cyl","disp")],
#'   z = mtcars[,c("hp","wt")], type = "latexSPSS")
#' table3 <- partialcor.table(mtcars[,c("mpg","cyl","disp")],
#'   z = mtcars[,c("hp","wt")], type = "manuscriptLatex")
#' table4 <- partialcor.table(mtcars[,c("mpg","cyl","disp")],
#'   z = mtcars[,c("hp","wt")], type = "manuscriptBigLatex")
#'
#' partialcor.table(mtcars[,c("mpg","cyl","disp")], mtcars[,c("drat","qsec")],
#'   mtcars[,c("hp","wt")])
#' partialcor.table(mtcars[,c("mpg","cyl","disp")], mtcars[,c("drat","qsec")],
#'   mtcars[,c("hp","wt")], type = "manuscript", dig = 3)

partialcor.table <- function(x, y, z = NULL, type = "none", dig = 2, correlation = "pearson"){
  if(missing(y)){
    if(is.null(names(z))){
      z <- data.frame(".missingnamez" = z)
    }

    xnames <- names(x)
    znames <- names(z)

    x <- as.matrix(x)
    z <- as.matrix(z)
    data <- cbind(x, z)

    bivariate.r <- tryCatch(rcorr(as.matrix(x))$r, error=function(e) NULL)

    cor.r <- tryCatch(partial.r(data = data, x = xnames, y = znames, method = correlation), error=function(e) NULL)

    cor.p <- cor.n <- matrix(nrow = nrow(cor.r), ncol = ncol(cor.r))

    for(i in 1: nrow(cor.r)){
      for(j in 1: ncol(cor.r)){
        cor.n[i, j] <- nrow(na.omit(data[,c(xnames[i], xnames[j], znames)]))
        cor.p[i, j] <- corr.p(r = cor.r, n = cor.n[i, j], adjust = "none")$p[i, j]
      }
    }

    diag(cor.p) <- NA

    r_rows <- 1:dim(cor.r)[1]*3 - 2
    p_rows <- 1:dim(cor.r)[1]*3 - 1
    n_rows <- 1:dim(cor.r)[1]*3
    r.table <- matrix(NA, nrow = 3*dim(cor.r)[1], ncol= dim(cor.r)[2])
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

    if(length(colnames(x))==0) {colnames(x) <- paste("var",1:dim(x)[2], sep = "")} else
      colnames(x) <- colnames(x)
    rownames(r.table) <- rep(paste("var", 1:length(colnames(x)), sep = ""),each=3)
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

    if(is.null(names(x))){
      x <- data.frame(".missingnamex" = x)
    }

    if(is.null(names(y))){
      y <- data.frame(".missingnamey" = y)
    }

    if(is.null(names(z))){
      z <- data.frame(".missingnamez" = z)
    }

    xnames <- names(x)
    ynames <- names(y)
    znames <- names(z)

    xynames <- c(xnames, ynames)

    x <- as.matrix(x)
    y <- as.matrix(y)
    z <- as.matrix(z)

    xWithy <- cbind(x,y)
    xWithyCovariates <- cbind(x,y,z)
    #continues even if error bc pair of variables has n=0 -> returns NAs
    cor.r <- tryCatch(partial.r(data = xWithyCovariates, x = xynames, y = znames, method = correlation), error=function(e) NULL)

    cor.p <- cor.n <- matrix(nrow = nrow(cor.r), ncol = ncol(cor.r))

    for(i in 1: nrow(cor.r)){
      for(j in 1: ncol(cor.r)){
        cor.n[i, j] <- nrow(na.omit(xWithyCovariates[,c(xynames[i], xynames[j], znames)]))
        cor.p[i, j] <- corr.p(r = cor.r, n = cor.n[i, j], adjust = "none")$p[i, j]
      }
    }

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
      colnames(xWithy) <- paste("var", 1:dim(xWithy)[2], sep = "")
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
    returnTable <- r.table
  } else if(type=="none"){
    returnTable <- r.table
  } else if(type=="latexSPSS"){
    returnTable <- r.table
  } else if (type=="latex"){
    returnTable <- xtable(r.table[1:(dim(r.table)[1]/3)*3-2,])
  } else if (type=="manuscript"){
    returnTable <- r.manuscript
  } else if (type=="manuscriptBig"){
    returnTable <- r.manuscriptBig
  } else if(type=="manuscriptLatex"){
    returnTable <- r.manuscript
  } else if(type=="manuscriptBigLatex"){
    returnTable <- r.manuscriptBig
  }

  return(returnTable)
}
