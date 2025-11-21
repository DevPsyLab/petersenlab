#' @title
#' Indexes of Effect Size for Measurement Noninvariance in Structural Equation
#' Models.
#'
#' @description
#' Function that estimates effect size indices for measurement noninvariance in
#' structural equation modeling.
#'
#' @details
#' From Newsom (2015):
#' Newsom, J. T. (2015). Longitudinal structural equation modeling: A
#' comprehensive introduction. Routledge.
#'
#' @param model_unconstrained \code{lavaan} model object for unconstrained
#' model.
#' @param model_constrained \code{lavaan} model object for constrained
#' model.
#'
#' @return \mjeqn{w}{w} and \mjeqn{\Delta \mathrm{M}_{\mathrm{C}}}{Delta M_C}.
#'
#' @family structural equation modeling
#'
#' @importFrom lavaan cfa lavInspect fitMeasures lavTestLRT
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' library("lavaan")
#'
#' # Model
#' HS.model <- '
#'   visual =~ x1 + x2 + x3
#'             textual =~ x4 + x5 + x6
#'             speed   =~ x7 + x8 + x9
#' '
#'
#' # configural invariance
#' fit1 <- lavaan::cfa(
#'   HS.model,
#'   data = HolzingerSwineford1939,
#'   group = "school")
#'
#' # weak invariance
#' fit2 <- lavaan::cfa(
#'   HS.model,
#'   data = HolzingerSwineford1939,
#'   group = "school",
#'   group.equal = "loadings")
#'
#' # strong invariance
#' fit3 <- lavaan::cfa(
#'   HS.model,
#'   data = HolzingerSwineford1939,
#'   group = "school",
#'   group.equal = c("intercepts", "loadings"))
#'
#' # model comparison tests
#' lavaan::lavTestLRT(fit1, fit2, fit3)
#'
#' # effect size of measurement noninvariance
#' measurementNoninvarianceEffectSize(
#'   model_unconstrained = fit1,
#'   model_constrained = fit2)
#'
#' measurementNoninvarianceEffectSize(
#'   model_unconstrained = fit2,
#'   model_constrained = fit3)

measurementNoninvarianceEffectSize <- function(
    model_unconstrained,
    model_constrained) {

  # extract sample size (if not provided)
  N <- sum(lavaan::lavInspect(model_unconstrained, "nobs"))

  # overall chi-square and df for unconstrained model
  chi_uncon <- as.numeric(lavaan::fitMeasures(model_unconstrained, "chisq"))
  df_uncon  <- as.numeric(lavaan::fitMeasures(model_unconstrained, "df"))

  # overall chi-square and df for constrained model
  chi_con <- as.numeric(lavaan::fitMeasures(model_constrained, "chisq"))
  df_con  <- as.numeric(lavaan::fitMeasures(model_constrained, "df"))

  # compute Mc for each model
  Mc_uncon <- exp(-0.5 * ((chi_uncon - df_uncon) / (N - 1)))
  Mc_con   <- exp(-0.5 * ((chi_con   - df_con)   / (N - 1)))

  # compute ΔMc
  delta_Mc <- Mc_uncon - Mc_con

  # compute Δχ2 and Δdf
  delta_chi <- chi_con - chi_uncon
  delta_df  <- df_con  - df_uncon

  # compute w
  w <- sqrt(delta_chi / (N * delta_df))

  # return results
  list(
    Mc_unconstrained = Mc_uncon,
    Mc_constrained   = Mc_con,
    Delta_Mc         = delta_Mc,
    w                = w
  )
}
