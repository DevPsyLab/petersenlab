#' @title
#' Proportional Reduction of Variance from Imputation Models.
#'
#' @description
#' Calculate the proportional reduction of variance in imputation models.
#'
#' @details
#' [INSERT].
#'
#' @param baseline The baseline model object fit with the imputed data.
#' @param full The full model object fit with the imputed data.
#' @param baselineTime The position of the random effect of time (random slopes) among the random slopes in the baseline model. For example:
#' \itemize{
#'  \item \code{0} = no random slopes
#'  \item \code{1} = time is the 1st random effect
#'  \item \code{2} = time is the second random effect
#' }
#' @param fullTime The position of the random effect of time (random slopes) among the random slopes in the full model. For example:
#' \itemize{
#'  \item \code{0} = no random slopes
#'  \item \code{1} = time is the 1st random effect
#'  \item \code{2} = time is the second random effect
#' }
#'
#' @return
#' The proportional reduction of variance from a baseline mixed-effects model
#' to a full mixed effects model.
#'
#' @family multipleImputation
#'
#' @export
#'
#' @importFrom mitools MIextract
#' @importFrom nlme intervals ranef VarCorr
#'
#' @examples
#' #INSERT

imputationPRV <- function(baseline, full, baselineTime = 1, fullTime = 1){
  randomSlopesBaseline <- dim(ranef(baseline[[1]]))[2]-1
  randomSlopesFull <- dim(ranef(full[[1]]))[2]-1

  varcovMatrixBaseline <- list()
  nPosDefBaseline <- 0
  modelPosDefBaseline <- list()
  j <- 1
  for (i in 1:length(baseline)) {
    varcovMatrixBaseline[[i]] <- try(intervals(baseline[[i]]), silent = TRUE)
    possibleError <- tryCatch(
      intervals(baseline[[i]]),
      error = function(e) e
    )
    if(!inherits(possibleError, "error")){
      nPosDefBaseline <- nPosDefBaseline + 1
      modelPosDefBaseline[[j]] <- baseline[[i]]
      j <- j + 1
    }
  }

  varcovMatrixFull <- list()
  nPosDefFull <- 0
  modelPosDefFull <- list()
  j <- 1
  for (i in 1:length(full)) {
    varcovMatrixFull[[i]] <- try(intervals(full[[i]]), silent = TRUE)
    possibleError <- tryCatch(
      intervals(full[[i]]),
      error = function(e) e
    )
    if(!inherits(possibleError, "error")){
      nPosDefFull <- nPosDefFull + 1
      modelPosDefFull[[j]] <- full[[i]]
      j <- j + 1
    }
  }

  baselineVar <- MIextract(modelPosDefBaseline, fun = VarCorr)
  fullVar <- MIextract(modelPosDefFull, fun = VarCorr)

  interceptBaseline <- vector()
  slopeBaseline <- vector()
  residualBaseline <- vector()
  for (i in 1:length(modelPosDefBaseline)){
    interceptBaseline[i] <- as.numeric(baselineVar[[i]][1])
    slopeBaseline[i] <- as.numeric(baselineVar[[i]][1 + baselineTime])
    residualBaseline[i] <- as.numeric(baselineVar[[i]][2 + randomSlopesBaseline])
  }

  interceptBaselineM <- mean(interceptBaseline)
  slopeBaselineM <- mean(slopeBaseline)
  residualBaselineM <- mean(residualBaseline)

  interceptFull <- vector()
  slopeFull <- vector()
  residualFull <- vector()
  for (i in 1:length(modelPosDefFull)){
    interceptFull[i] <- as.numeric(fullVar[[i]][1])
    slopeFull[i] <- as.numeric(fullVar[[i]][1 + fullTime])
    residualFull[i] <- as.numeric(fullVar[[i]][2 + randomSlopesFull])
  }

  interceptFullM <- mean(interceptFull)
  slopeFullM <- mean(slopeFull)
  residualFullM <- mean(residualFull)

  PRVresidual <- (residualBaselineM - residualFullM) / residualBaselineM
  PRVintercept <- (interceptBaselineM - interceptFullM) / interceptBaselineM
  PRVslope <- (slopeBaselineM - slopeFullM) / slopeBaselineM

  if(randomSlopesBaseline == 0 | randomSlopesFull == 0){
    output <- as.data.frame(cbind(PRVresidual, PRVintercept))
  } else{
    output <- as.data.frame(cbind(PRVresidual, PRVintercept, PRVslope))
  }
  return(output)
}
