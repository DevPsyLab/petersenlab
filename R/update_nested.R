#' @title
#' Update Nested Models in Hierarchical Regression.
#'
#' @description
#' Wrapper function to ensure the same observations are used for
#' each updated model as were used in the first model.
#'
#' @details
#' Convenience wrapper function to ensure the same observations are used for
#' each updated model as were used in the first model, to ensure comparability
#' of models.
#'
#' @param object model object to update
#' @param formula. updated model formula
#' @param evaluate whether to evaluate the model. One of: \code{TRUE} or
#' \code{FALSE}
#'
#' @return \code{lm} model
#'
#' @family multipleRegression
#'
#' @importFrom stats lm anova
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' data("mtcars")
#'
#' dat <- mtcars
#'
#' # Create some missing values in mtcars
#' dat[1, "wt"] <- NA
#' dat[5, "cyl"] <- NA
#' dat[7, "hp"] <- NA
#'
#' m1 <- lm(mpg ~ wt + cyl + hp, data = dat)
#' m2 <- update_nested(m1, . ~ . - wt)  # Remove wt
#' m3 <- update_nested(m1, . ~ . - cyl) # Remove cyl
#' m4 <- update_nested(m1, . ~ . - wt - cyl) # Remove wt and cyl
#' m5 <- update_nested(m1, . ~ . - wt - cyl - hp) # Remove all three variables (i.e., model with intercept only)
#'
#' anova(m1, m2, m3, m4, m5)
#'
#' @seealso
#' \url{https://stackoverflow.com/a/37341927}
#'
#' \url{https://stackoverflow.com/a/37416336}
#'
#' \url{https://stackoverflow.com/a/47195348}

update_nested <- function(object, formula., ..., evaluate = TRUE){
  update(
    object = object,
    formula. = formula.,
    data = object$model,
    ...,
    evaluate = evaluate)
}
