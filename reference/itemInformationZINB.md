# Item and Test Information from Zero-Inflated Negative Binomial Model.

Estimate item and test information from Bayesian zero-inflated negative
binomial model that was fit using the `brms` package.

## Usage

``` r
deriv_d_negBinom(n, alpha, beta, theta, phi)

d_negBinom(n, alpha, beta, theta, phi)

log_gen_binom(n, phi)

deriv_logd_negBinom(n, alpha, beta, theta, phi)

info_neg_binom_analytical(
  theta = seq(-2.5, 2.5, length.out = 101),
  alpha,
  beta,
  phi,
  varpi
)

item_info_NB_zero_analytical(theta, alpha, beta, phi, varpi)

item_info_NB_analytical(theta, alpha, beta, phi, varpi = NULL, zero = FALSE)

test_info_NB(theta, alpha, beta, phi, varpi = NULL, zero = FALSE)

error_variance_NB(
  lower = -Inf,
  upper = Inf,
  alpha,
  beta,
  phi,
  varpi = NULL,
  zero = FALSE
)

reliability_NB(alpha, beta, phi, varpi = NULL, zero = FALSE)
```

## Arguments

- n:

  Integer. The observed count, representing the the event frequency.

- alpha:

  Numeric. The slope/discrimination parameter of the item, indicating
  how steeply the item response changes with the person's (`theta`).

- beta:

  Numeric. The intercept/easiness parameter of the item, indicating the
  expected count at a given level on the construct (`theta`).

- theta:

  Numeric. The respondent's level on the latent factor/construct.

- phi:

  Numeric. The shape/overdispersion parameter of the negative binomial
  distribution, indicating the variance beyond what is expected from a
  negative binomial distribution.

- varpi:

  Numeric. The probability of observing a zero count due to a separate
  zero-inflation process.

- zero:

  TRUE/FALSE. Whether the item is a from a zero-inflated model.

- lower:

  Numeric. The lower range of theta, for estimating error variance or
  reliability.

- upper:

  Numeric. The upper range of theta, for estimating error variance or
  reliability.

## Value

The amount of information for a given item (or the test as a whole) at
each of the values of `theta` specified. Based on test information, one
can estimate error variance and marginal reliability using
`error_variance_NB()` and `reliability_NB()`, respectively.

## Details

Created by Philipp Doebler (doebler@statistik.tu-dortmund.de) and Loreen
Sabel (loreen.sabel@tu-dortmund.de).

## See also

Other bayesian:
[`pA()`](https://devpsylab.github.io/petersenlab/reference/bayesTheorem.md)

Other IRT:
[`calc_grm_probs()`](https://devpsylab.github.io/petersenlab/reference/itemInformationGRM.md),
[`discriminationToFactorLoading()`](https://devpsylab.github.io/petersenlab/reference/discriminationToFactorLoading.md),
[`fourPL()`](https://devpsylab.github.io/petersenlab/reference/fourPL.md),
[`itemInformation()`](https://devpsylab.github.io/petersenlab/reference/itemInformation.md),
[`reliabilityIRT()`](https://devpsylab.github.io/petersenlab/reference/reliabilityIRT.md),
[`standardErrorIRT()`](https://devpsylab.github.io/petersenlab/reference/standardErrorIRT.md),
[`test_info_4PL()`](https://devpsylab.github.io/petersenlab/reference/testInformation.md)

## Examples

``` r
if (FALSE) { # \dontrun{
library("brms")
library("rstan")

coef_bayesianMixedEffectsGRM_gam <- coef(bayesianMixedEffectsGRM_gam)
str(coef_bayesianMixedEffectsGRM_gam)
itempars <- coef_bayesianMixedEffectsGRM_gam$item[,1,1:4]

# define a grid of thetas for the computations:
theta_seq <- seq(-4, 4, length.out = 201)

# item information for all items
# The resulting matrix has length(theta_seq) columns and a row per item.
# We use a loop for the calculations
item_info <- matrix(NA, nrow = nrow(itempars), ncol = length(theta_seq))
for(i in 1:nrow(itempars)){
  item_info[i, ] <- item_info_NB_zero_analytical(
    theta = theta_seq,
    alpha = itempars[i, "alpha_Intercept"],
    beta = itempars[i, "beta_Intercept"],
    phi = exp(itempars[i, "shape_Intercept"]),
    varpi = plogis(itempars[i, "zi_Intercept"]))
}

test_info <- data.frame(
  theta = theta_seq,
  testInformation = colSums(item_info)
)

# Or, alternatively:
test_info_NB(
  theta = compareTestInfo$theta,
  alpha = itempars[,"alpha_Intercept"],
  beta = itempars[,"beta_Intercept"],
  phi = exp(itempars[,"shape_Intercept"]),
  varpi = plogis(itempars[,"zi_Intercept"]),
  zero = TRUE)

# Test Standard Error of Measurement in Different Theta Ranges
error_variance_NB(
  lower = -4,
  upper = 4,
  alpha = itempars[,"alpha_Intercept"],
  beta = itempars[,"beta_Intercept"],
  phi = exp(itempars[,"shape_Intercept"]),
  varpi = plogis(itempars[,"zi_Intercept"]),
  zero = TRUE
)

error_variance_NB(
  lower = -4,
  upper = 0,
  alpha = itempars[,"alpha_Intercept"],
  beta = itempars[,"beta_Intercept"],
  phi = exp(itempars[,"shape_Intercept"]),
  varpi = plogis(itempars[,"zi_Intercept"]),
  zero = TRUE
)

error_variance_NB(
  lower = 0,
  upper = 1.5,
  alpha = itempars[,"alpha_Intercept"],
  beta = itempars[,"beta_Intercept"],
  phi = exp(itempars[,"shape_Intercept"]),
  varpi = plogis(itempars[,"zi_Intercept"]),
  zero = TRUE
)

error_variance_NB(
  lower = 1.5,
  upper = 4,
  alpha = itempars[,"alpha_Intercept"],
  beta = itempars[,"beta_Intercept"],
  phi = exp(itempars[,"shape_Intercept"]),
  varpi = plogis(itempars[,"zi_Intercept"]),
  zero = TRUE
)

# One-Number Summary of Test Reliability
reliability_NB(
  alpha = itempars[,"alpha_Intercept"],
  beta = itempars[,"beta_Intercept"],
  phi = exp(itempars[,"shape_Intercept"]),
  varpi = plogis(itempars[,"zi_Intercept"]),
  zero = TRUE)
} # }
```
