#' @title
#' Summarize mixed effects model.
#'
#' @description
#' Summarizes the results of a model fit by the \code{lme()} function of the
#' \code{nlme} package.
#'
#' @details
#' Summarizes the results of a model fit by the \code{lme()} function of the
#' \code{nlme} package. Includes summary of parameters, pseudo-r-squared, and
#' whether model is positive definite.
#'
#' @param model name of \code{lme()} model object.
#' @param dig number of decimals to print in output.
#'
#' @return Output summary of \code{lme()} model object.
#'
#' @family mixedModel
#'
#' @importFrom nlme lme intervals getResponse
#' @importFrom stats cor
#'
#' @export
#'
#' @examples
#' # Fit Model
#' library("nlme")
#' model <- lme(distance ~ age + Sex, data = Orthodont, random = ~ 1 + age)
#'
#' # Model Summary
#' summary(model)
#' lmeSummary(model)

lmeSummary <- function(model, dig = 3){
  output <- list()

  try(intervals(model), silent = TRUE)
  possibleError <- tryCatch(
    intervals(model),
    error = function(e) e
  )
  if(!inherits(possibleError, "error")){
    PosDef <- "Yes"
  } else {
    PosDef <- "No"
  }

  results <- round(summary(model)$tTable, dig)
  observed <- getResponse(model)
  predicted <- predict(model)
  pseudoRsquared <- round(cor(observed, predicted, use = "pairwise.complete.obs", method = "pearson")^2, dig)

  modelPosDef <- paste("Positive Definite: ", PosDef, sep = "")
  modelFit <- paste("Pseudo R-square: ", pseudoRsquared, sep = "")
  modelInfo <- rbind(modelPosDef, modelFit)

  output[[1]] <- modelInfo
  output[[2]] <- results
  print(output, quote = FALSE)
}
