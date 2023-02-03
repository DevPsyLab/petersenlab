#' @title
#' Combine Results from Mixed Effect Imputation Models.
#'
#' @description
#' Function that combines lme results across multiple imputation runs.
#'
#' @details
#' [INSERT].
#'
#' @param model name of \code{lme()} model object with multiply imputed data.
#' @param dig number of decimals to print in output.
#'
#' @return
#' Summary of model fit and information for mixed effect imputation models.
#'
#' @family multipleImputation
#'
#' @importFrom nlme fixef
#' @importFrom mix mi.inference
#' @importFrom stats na.omit
#'
#' @export
#'
#' @examples
#' #INSERT

imputationCombine <- function(model, dig = 3){
  varcovMatrix <- list()
  nPosDef <- 0
  modelPosDef <- list()
  j <- 1
  for (i in 1:length(model)) {
    varcovMatrix[[i]] <- try(intervals(model[[i]]), silent = TRUE)
    possibleError <- tryCatch(
      intervals(model[[i]]),
      error = function(e) e
    )
    if(!inherits(possibleError, "error")){
      nPosDef <- nPosDef+1
      modelPosDef[[j]] <- model[[i]]
      j <- j+1
    }
  }
  betas <- MIextract(modelPosDef, fun = fixef)
  vars <- MIextract(modelPosDef, fun = vcov)
  vars2 <- list()
  for ( i in 1:length(modelPosDef)) { vars2[[i]] <- as.matrix(vars[[i]])  }

  se.lme <- MIextract(modelPosDef, fun = function(x){
    sqrt(diag(vcov(x)))
  })

  observed <- data.frame()
  predicted <- data.frame()
  pseudoRsquared <- vector()
  for (i in 1:length(modelPosDef)){
    observed[1:length(na.omit(MIextract(modelPosDef, fun=getResponse)[[i]])),i] <- na.omit(MIextract(modelPosDef, fun = getResponse)[[i]])
    predicted[1:length(na.omit(MIextract(modelPosDef, fun=getResponse)[[i]])),i] <- modelPosDef[[i]]$fitted[,2]
    pseudoRsquared[i] <- cor(observed[,i],predicted[,i], use = "everything", method = "pearson")^2
  }
  pseudoR2 <- round(mean(pseudoRsquared), dig)

  modelSummary <- paste("Positive Definite Models: ", nPosDef, "/", length(model), sep = "")
  modelFit <- paste("Pseudo R-square: ", pseudoR2, sep = "")
  modelInfo <- rbind(modelSummary, modelFit)

  output <- list(round(as.data.frame(mi.inference(betas, se.lme)), dig), modelInfo)
  return(output)
}
