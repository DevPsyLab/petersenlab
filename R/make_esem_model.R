#' @title
#' Make ESEM Model.
#'
#' @description
#' Make \code{lavaan} syntax for exploratory structural equation model (ESEM).
#'
#' @details
#' Makes syntax for exploratory structural equation model (ESEM) to be fit in
#' \code{lavaan}.
#'
#' @param loadings Dataframe with three columns from exploratory factor
#' analysis (EFA):
#' \itemize{
#'   \item \code{latent} = name of the latent factor(s)
#'   \item \code{item} = name of the item(s)/indicator(s)
#'   \item \code{loading} = parameter estimate of the factor loading item
#'   factor loading on the latent factor
#' }
#' @param anchors Dataframe whose names are the latent factors and whose values
#' are the names of the anchor item for each latent factor.
#'
#' @return
#' \code{lavaan} model syntax.
#'
#' @family lavaan
#'
#' @importFrom dplyr %>% filter select rename
#' @importFrom lavaan sem parameterEstimates
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' data("HolzingerSwineford1939", package = "lavaan")
#'
#' # Specify EFA Syntax
#' efa_syntax <- '
#'   # EFA Factor Loadings
#'   efa("efa1")*f1 +
#'   efa("efa1")*f2 +
#'   efa("efa1")*f3 =~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9
#' '
#'
#' # Fit EFA Model
#' mplusRotationArgs <- list(rstarts = 30,
#'   row.weights = "none",
#'   algorithm = "gpa",
#'   orthogonal = FALSE,
#'   jac.init.rot = TRUE,
#'   std.ov = TRUE, # row standard = correlation
#'   geomin.epsilon = 0.0001)
#'
#' efa_fit <- lavaan::sem(
#'   efa_syntax,
#'   data = HolzingerSwineford1939,
#'   information = "observed",
#'   missing = "ML",
#'   estimator = "MLR",
#'   rotation = "geomin",
#'   # mimic Mplus
#'   meanstructure = TRUE,
#'   rotation.args = mplusRotationArgs)
#'
#' # Extract Factor Loadings
#' esem_loadings <- lavaan::parameterEstimates(
#'   efa_fit,
#'   standardized = TRUE
#' ) %>%
#'   filter(efa == "efa1") %>%
#'   select(lhs, rhs, est) %>%
#'   rename(item = rhs, latent = lhs, loading = est)
#'
#' # Specify Anchor Item for Each Latent Factor
#' anchors <- c(f1 = "x3", f2 = "x5", f3 = "x7")
#'
#' # Generate ESEM Syntax
#' esemModel_syntax <- make_esem_model(esem_loadings, anchors)
#'
#' # Fit ESEM Model
#' lavaan::sem(
#'   esemModel_syntax,
#'   data = HolzingerSwineford1939,
#'   missing = "ML",
#'   estimator = "MLR")
#'
#' @seealso
#' \url{https://msilvestrin.me/post/esem/}

make_esem_model <- function(loadings, anchors){
  # Make variable indicating whether an item loading is an anchor loading (i.e., fixed to the EFA result)
  loadings$is_anchor <- 0
  for(i in 1:length(anchors)){
    loadings[which(loadings$latent != names(anchors)[i] & loadings$item == anchors[i]), "is_anchor"] <- 1
  }

  # Make syntax for each per item (which differs depending on whether the item loading is an anchor loading)
  loadings$syntax <- NA
  loadings[which(loadings$is_anchor == 0), "syntax"] <- paste("start(", loadings$loading, ")*", loadings$item, sep = "")[which(loadings$is_anchor == 0)]
  loadings[which(loadings$is_anchor == 1), "syntax"] <- paste(loadings$loading, "*", loadings$item, sep = "")[which(loadings$is_anchor == 1)]

  # Make syntax for each latent variable
  each_syntax <- function(latent){
    paste(latent, "=~", paste(loadings[which(loadings$latent == latent), "syntax"], collapse = "+", sep = ""),"\n")
  }

  # Put all syntax together
  lavaanSyntax <-
    paste(sapply(unique(loadings$latent), each_syntax), collapse = " ")

  return(lavaanSyntax)
}
