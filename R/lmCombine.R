#' @title
#' Combine Results from Multiple Regression Imputation Models.
#'
#' @description
#' Function that combines \code{lm()} results across multiple imputation runs.
#'
#' @details
#' [INSERT].
#'
#' @param model name of \code{lm()} model object with multiply imputed data.
#' @param dig number of decimals to print in output.
#'
#' @return
#' Summary of multiple regression imputation models.
#'
#' @family multipleImputation
#'
#' @importFrom mix mi.inference
#' @importFrom stats vcov lm
#'
#' @export
#'
#' @examples
#' #INSERT

lmCombine <- function(model, dig = 3){
  betas <- MIextract(model, fun = coef)
  se.lme <- MIextract(model, fun = function(x){
    sqrt(diag(vcov(x)))
  })

  mi.inference(betas, se.lme)
  round(mi.inference(betas, se.lme)$est,5)

  output <- round(as.data.frame(mi.inference(betas, se.lme)), dig)
  return(output)
}
