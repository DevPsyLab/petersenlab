#' @title
#' Weighted Quantiles.
#'
#' @description
#' Computes weighted quantiles. \code{whdquantile()} uses a weighted
#' Harrell-Davis quantile estimator. \code{wthdquantile()} uses a weighted
#' trimmed Harrell-Davis quantile estimator. \code{wquantile()} uses a weighted
#' traditional quantile estimator.
#'
#' @details
#' Computes weighted quantiles according to Akinshin (2023).
#'
#' @param x Numeric vector of values of which to determine the quantiles.
#' @param w Numeric vector of weights to give each value. Should be the same
#' length as the vector of values.
#' @param probs Numeric vector of the quantiles to retrieve.
#'
#' @return Numeric vector of specified quantiles.
#'
#' @family computations
#'
#' @importFrom utils tail head
#' @importFrom stats pbeta dbeta uniroot
#'
#' @examples
#' mydata <- c(1:100, 1000)
#' mydataWithNAs <- mydata
#' mydataWithNAs[c(1,5,7)] <- NA
#' weights <- rep(1, length(mydata))
#' quantiles <- c(0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99)
#'
#' whdquantile(
#'   x = mydata,
#'   w = weights,
#'   probs = quantiles)
#'
#' wthdquantile(
#'   x = mydata,
#'   w = weights,
#'   probs = quantiles)
#'
#' wquantile(
#'   x = mydata,
#'   w = weights,
#'   probs = quantiles)
#'
#' whdquantile(
#'   x = mydataWithNAs,
#'   w = weights,
#'   probs = quantiles)
#'
#' wthdquantile(
#'   x = mydataWithNAs,
#'   w = weights,
#'   probs = quantiles)
#'
#' wquantile(
#'   x = mydataWithNAs,
#'   w = weights,
#'   probs = quantiles)
#'
#' @seealso
#' \doi{10.48550/arXiv.2304.07265}

#' @rdname weightedQuantile
#' @export
# Kish's effective sample size
kish_ess <- function(w) sum(w)^2 / sum(w^2)

#' @param cdf Cumulative distribution function.
#' @rdname weightedQuantile
#' @export
# Weighted generic quantile estimator
wquantile_generic <- function(x, w, probs, cdf) {
  n <- length(x)
  if (is.null(w)) {
    w <- rep(1 / n, n)
  }
  if (any(is.na(x))) {
    w <- w[!is.na(x)]
    x <- x[!is.na(x)]
  }

  nw <- kish_ess(w)

  indexes <- order(x)
  x <- x[indexes]
  w <- w[indexes]

  w <- w / sum(w)
  t <- cumsum(c(0, w))

  sapply(probs, function(p) {
    cdf_values <- cdf(nw, p, t)
    W <- tail(cdf_values, -1) - head(cdf_values, -1)
    sum(W * x)
  })
}

#' @rdname weightedQuantile
#' @export
# Weighted Harrell-Davis quantile estimator
whdquantile <- function(x, w, probs) {
  cdf <- function(n, p, t) {
    if (p == 0 || p == 1)
      return(rep(NA, length(t)))
    pbeta(t, (n + 1) * p, (n + 1) * (1 - p))
  }
  wquantile_generic(x, w, probs, cdf)
}

#' @param width Numeric value for the width of the interval in the trimmed
#' Harrell-Davis quantile estimator.
#' @rdname weightedQuantile
#' @export
# Weighted trimmed Harrell-Davis quantile estimator
wthdquantile <- function(x, w, probs, width = 1 / sqrt(kish_ess(w)))
  sapply(probs, function(p) {
    getBetaHdi <- function(a, b, width) {
      eps <- 1e-9
      if (a < 1 + eps & b < 1 + eps) # Degenerate case
        return(c(NA, NA))
      if (a < 1 + eps & b > 1) # Left border case
        return(c(0, width))
      if (a > 1 & b < 1 + eps) # Right border case
        return(c(1 - width, 1))
      if (width > 1 - eps)
        return(c(0, 1))

      # Middle case
      mode <- (a - 1) / (a + b - 2)
      pdf <- function(x) dbeta(x, a, b)

      l <- uniroot(
        f = function(x) pdf(x) - pdf(x + width),
        lower = max(0, mode - width),
        upper = min(mode, 1 - width),
        tol = 1e-9
      )$root
      r <- l + width
      return(c(l, r))
    }

    nw <- kish_ess(w)
    a <- (nw + 1) * p
    b <- (nw + 1) * (1 - p)
    hdi <- getBetaHdi(a, b, width)
    hdiCdf <- pbeta(hdi, a, b)
    cdf <- function(n, p, t) {
      if (p == 0 || p == 1)
        return(rep(NA, length(t)))
      t[t <= hdi[1]] <- hdi[1]
      t[t >= hdi[2]] <- hdi[2]
      (pbeta(t, a, b) - hdiCdf[1]) / (hdiCdf[2] - hdiCdf[1])
    }
    wquantile_generic(x, w, p, cdf)
  })

#' @param type Numeric value for type of weighted quantile.
#' @rdname weightedQuantile
#' @export
# Weighted traditional quantile estimator
wquantile <- function(x, w, probs, type = 7) {
  if (!(type %in% 4:9)) {
    stop(paste("Unsupported type:", type))
  }
  cdf <- function(n, p, t) {
    h <- switch(type - 3,
                n * p,                   # Type 4
                n * p + 0.5,             # Type 5
                (n + 1) * p,             # Type 6
                (n - 1) * p + 1,         # Type 7
                (n + 1 / 3) * p + 1 / 3, # Type 8
                (n + 1 / 4) * p + 3 / 8  # Type 9
    )
    h <- max(min(h, n), 1)
    pmax(0, pmin(1, t * n - h + 1))
  }
  wquantile_generic(x, w, probs, cdf)
}
