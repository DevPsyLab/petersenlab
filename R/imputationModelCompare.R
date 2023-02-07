#' @title
#' Compare Mixed Effect Imputation Models.
#'
#' @description
#' Function that compares two nested \code{lme()} models from multiple
#' imputation using likelihood ratio test.
#'
#' @details
#' [INSERT].
#'
#' @param model1 name of first \code{lme()} model object with multiply imputed
#' data.
#' @param model2 name of second \code{lme()} model object with multiply imputed
#' data.
#'
#' @return
#' Likelihood ratio test for model comparison of two mixed effect imputation
#' models.
#'
#' @family multipleImputation
#'
#' @importFrom stats logLik
#'
#' @export
#'
#' @examples
#' #INSERT

imputationModelCompare <- function(model1, model2){
  output <- data.frame()
  varcovMatrix1 <- list()
  varcovMatrix2 <- list()
  nPosDef1 <- 0
  nPosDef2 <- 0
  j1 <- 1
  j2 <- 1
  model1PosDef <- list()
  model2PosDef <- list()
  loglikmodel1 <- vector()
  dfmodel1 <- vector()
  loglikmodel2 <- vector()
  dfmodel2 <- vector()

  for (i in 1:length(model1)) {
    varcovMatrix1[[i]] <- try(intervals(model1[[i]]), silent = TRUE)
    possibleError1 <- tryCatch(
      intervals(model1[[i]]),
      error = function(e) e
    )
    if(!inherits(possibleError1, "error")){
      nPosDef1 <- nPosDef1+1
      model1PosDef[[j1]] <- model1[[i]]
      j1 <- j1+1
    }
  }
  for (i in 1:length(model1PosDef)){
    loglikmodel1[i] <- logLik(model1PosDef[[i]])[1]
    dfmodel1[i] <- attr(logLik(model1PosDef[[i]]),"df")
  }

  for (i in 1:length(model2)) {
    varcovMatrix2[[i]] <- try(intervals(model2[[i]]), silent = TRUE)
    possibleError2 <- tryCatch(
      intervals(model2[[i]]),
      error = function(e) e
    )
    if(!inherits(possibleError2, "error")){
      nPosDef2 <- nPosDef2+1
      model2PosDef[[j2]] <- model2[[i]]
      j2 <- j2+1
    }
  }
  for (i in 1:length(model2PosDef)){
    loglikmodel2[i] <- logLik(model2PosDef[[i]])[1]
    dfmodel2[i] <- attr(logLik(model2PosDef[[i]]), "df")
  }

  loglik1 <- mean(loglikmodel1, na.rm = TRUE)
  loglik2 <- mean(loglikmodel2, na.rm = TRUE)
  df1 <- mean(dfmodel1, na.rm=TRUE)
  df2 <- mean(dfmodel2, na.rm=TRUE)
  chisqVal <- abs(loglik1) - abs(loglik2)
  chisqDF <- df2 - df1
  pval <- 1 - pchisq(chisqVal, df = chisqDF)

  model <- c("Model1","Model2")
  logLikelihood <- c(loglik1, loglik2)
  df <- c(df1, df2)
  chisqdiff <- c(chisqVal, NA)
  pvalue <- c(pval, NA)

  output <- data.frame(model, logLikelihood, df, chisqdiff, pvalue)
  return(output)
}
