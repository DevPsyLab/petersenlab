#' @title
#' Obtain standardized regression coefficients from lmer model.
#'
#' @description
#' Obtains standardized regression coefficients from the results of a model fit
#' by the \code{lme4()} function of the \code{lmer} package.
#'
#' @details
#' Obtains standardized regression coefficients from the results of a model fit
#' by the \code{lmer()} function of the \code{lme4} package.
#'
#' @param model name of \code{lmer()} model object.
#'
#' @return Standardized regression coefficients of \code{lmer()} model object.
#'
#' @family mixedModel
#'
#' @importFrom lme4 lmer fixef getME
#' @importFrom stats sd
#'
#' @export
#'
#' @examples
#' # Fit Model
#' library("lme4")
#'
#' sleepstudy$DaySq <- sleepstudy$Days^2
#' model <- lme4::lmer(Reaction ~ Days + DaySq + (Days | Subject), sleepstudy)
#'
#' # Standardized regression coefficients
#' lm.beta.lmer(model)
#'
#' @seealso
#' \url{https://stats.stackexchange.com/a/123448}

lm.beta.lmer <- function(model) {
  # Extract fixed effect coefficients
  b <- lme4::fixef(model)

  # Drop intercept if present
  if ("(Intercept)" %in% names(b)) {
    b <- b[-1]
  }

  # Get fixed effects design matrix and drop intercept column
  X <- lme4::getME(model, "X")
  if ("(Intercept)" %in% colnames(X)) {
    X <- X[, colnames(X) != "(Intercept)", drop = FALSE]
  }

  # Standard deviations
  sd.x <- apply(X, 2, sd)
  sd.y <- stats::sd(lme4::getME(model, "y"))

  # Handle case with no predictors (e.g., intercept-only model)
  if (length(b) == 0) {
    return(numeric(0))
  }

  # Compute standardized coefficients
  beta <- b * sd.x / sd.y

  return(beta)
}
