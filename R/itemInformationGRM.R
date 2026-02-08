#' @title
#' Item Information in graded response model in item response theory.
#'
#' @description
#' Item information in graded response model in item response theory.
#'
#' @details
#' Estimates the amount of information provided by a given item in a graded
#' response model in item response theory as function of the item parameters
#' and the person's level on the construct (theta).
#'
#' @param a Discrimination parameter (slope).
#' @param b_thresholds Difficulty (severity) parameters (inflection point). Can
#' be provided either as a vector (for a given item) or as a list (for multiple
#' items).
#' @param theta Person's level on the construct.
#' @param x Dataframe.
#'
#' @return
#' \code{calc_grm_probs()} returns the probability of each response category;
#' \code{itemInformationGRM()} returns the amount of item information.
#'
#' @family IRT
#'
#' @importFrom stats plogis
#'
#' @export
#'
#' @examples
#' calc_grm_probs(
#'  a = 1,
#'  b_thresholds = 0,
#'  theta = -4:4
#' )
#'
#' calc_grm_probs(
#'  a = 1,
#'  b_thresholds = c(-1, 1),
#'  theta = -4:4
#' )
#'
#' itemInformationGRM(
#'  a = 1,
#'  b_thresholds = 0,
#'  theta = -4:4
#' )
#'
#' itemInformationGRM(
#'  a = 1,
#'  b_thresholds = c(-1, 1),
#'  theta = -4:4
#' )
#'
#' itemParameters <- data.frame(
#'  item = c(1, 2, 3),
#'  a = c(0.5, 1, 1.5),
#'  b1 = c(-1, 0, 1),
#'  b2 = c(0, 1, 2),
#'  b3 = c(1, 2, 3)
#' )
#'
#' calc_grm_probs(
#'  a = itemParameters$a,
#'  b_thresholds = get_thresholds(itemParameters),
#'  theta = -4:4)
#'
#'
#' itemInformationGRM(
#'  a = itemParameters$a,
#'  b_thresholds = get_thresholds(itemParameters),
#'  theta = -4:4)
#'

#' @rdname itemInformationGRM
#' @export
# Calculate probability of each response category
calc_grm_probs <- function(a, b_thresholds, theta) {
  if (!is.list(b_thresholds)) b_thresholds <- list(b_thresholds)

  probs_list <- vector("list", length(a))

  for (i in seq_along(a)) {
    b <- b_thresholds[[i]]
    # Cumulative probabilities: P* (k or higher)
    cum_probs <- plogis(outer(X = theta, Y = b, FUN = function(th, b_val) a[i] * (th - b_val)))

    # Boundaries for GRM: P*0 = 1, P*last = 0
    cum_probs_extended <- cbind(1, cum_probs, 0)

    # Category probabilities
    probs <- t(apply(X = cum_probs_extended, MARGIN = 1, FUN = function(x) -diff(x)))
    probs_list[[i]] <- probs
  }

  names(probs_list) <- names(a)

  return(probs_list)
}

#' @rdname itemInformationGRM
#' @export
# Calculate item information
itemInformationGRM <- function(a, b_thresholds, theta) {
  if (!is.list(b_thresholds)) b_thresholds_ <- list(b_thresholds)

  info_list <- vector("list", length(a))

  for (i in seq_along(a)) {
    b <- b_thresholds[[i]]

    # 1. Cumulative probabilities
    cum_probs <- plogis(outer(X = theta, Y = b, FUN = function(th, b_val) a[i] * (th - b_val)))
    cum_probs_extended <- cbind(1, cum_probs, 0)

    # 2. Category probabilities
    p <- t(apply(X = cum_probs_extended, MARGIN = 1, FUN = function(x) -diff(x)))

    # 3. Derivatives
    W <- cum_probs_extended * (1 - cum_probs_extended)
    P_k_prime <- a[i] * t(apply(X = W, MARGIN = 1, FUN = function(x) -diff(x)))

    # 4. Fisher information
    info_list[[i]] <- rowSums((P_k_prime^2) / (p))
  }

  names(info_list) <- names(a)

  return(info_list)
}

#' @rdname itemInformationGRM
#' @export
# Helper function to extract thresholds from item parameters data frame
get_thresholds <- function(x) {
  if (is.data.frame(x)) {
    # Return a list: one numeric vector per item
    b_cols <- grep("^b[0-9]+$", names(x), value = TRUE)
    purrr::map(seq_len(nrow(x)), ~ as.numeric(x[.x, b_cols]))
  } else {
    # Single row
    b_cols <- grep("^b[0-9]+$", names(x), value = TRUE)
    as.numeric(x[b_cols])
  }
}
