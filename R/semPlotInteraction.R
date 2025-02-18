#' @title
#' Plot interaction from SEM model.
#'
#' @description
#' Generates a plot of a 2-way interaction from a structural equation model
#' (SEM) that was estimated using the lavaan package.
#'
#' @details
#' Created by Johanna Caskey (johanna-caskey@uiowa.edu).
#'
#' @param data the dataframe object from which the model was derived
#' @param fit the fitted model lavaan object
#' @param predictor the variable name of the predictor variable that is in its
#' raw metric (in quotes)
#' @param centered_predictor the variable name of the mean-centered predictor
#' variable as it appears in the model object syntax in lavaan (in quotes)
#' @param moderator the variable name of the moderator variable that is in its
#' raw metric (in quotes)
#' @param centered_moderator the variable name of the mean-centered moderator
#' variable that as it appears in the model object syntax in lavaan (in quotes)
#' @param interaction the variable name of the interaction term as it appears in
#' the model object syntax in lavaan (in quotes)
#' @param outcome the variable name of the outcome variable as it appears in the
#' model object syntax in lavaan (in quotes)
#' @param covariates default NULL; a vector of the names of the covariate
#' variables as they appear in the model object syntax in lavaan (each in
#' quotes)
#' @param ignore default NULL; a vector of the names of any variables
#' (as they appear in the model object syntax in lavaan) to ignore when 
#' creating model implied predicted data (each in quotes)
#' @param predStr default NULL; optional addition of an x-axis title for the
#' name of the predictor variable (in quotes); if left unset,
#' plot label will default to "Predictor"
#' @param modStr default NULL; optional addition of an z-axis title for the
#' name of the moderator variable (in quotes); if left unset,
#' plot label will default to "Moderator"
#' @param outStr default NULL; optional addition of an x-axis title for the
#' name of the outcome variable (in quotes); if left unset,
#' plot label will default to "Outcome"
#'
#' @return
#' Plot of two-way interaction from structural equation model.
#'
#' @family plot
#' @family multipleRegression
#' @family structural equation modeling
#'
#' @importFrom lavaan sem lavPredictY
#' @importFrom ggplot2 aes geom_line labs
#' @importFrom dplyr mutate case_when
#'
#' @export
#'
#' @examples
#' states <- as.data.frame(state.x77)
#' names(states)[which(names(states) == "HS Grad")] <- "HS.Grad"
#' states$Income_rescaled <- states$Income/100
#'
#' # Mean Center Predictors
#' states$Illiteracy_centered <- scale(states$Illiteracy, scale = FALSE)
#' states$Murder_centered <- scale(states$Murder, scale = FALSE)
#'
#' # Compute Interaction Term
#' states$interaction <- states$Illiteracy_centered * states$Murder_centered
#'
#' # Specify model syntax
#' moderationModel <- '
#'   Income_rescaled ~ Illiteracy_centered + Murder_centered + interaction +
#'   HS.Grad
#' '
#'
#' # Fit the model
#' moderationFit <- lavaan::sem(
#'   moderationModel,
#'   data = states,
#'   missing = "ML",
#'   estimator = "MLR",
#'   fixed.x = FALSE)
#'
#' # Pass model to function (unlabeled plot)
#' semPlotInteraction(
#'   data = states,
#'   fit = moderationFit,
#'   predictor = "Illiteracy",
#'   centered_predictor = "Illiteracy_centered",
#'   moderator = "Murder",
#'   centered_moderator = "Murder_centered",
#'   interaction = "interaction",
#'   outcome = "Income_rescaled",
#'   covariates = "HS.Grad",
#'   ignore = NULL,)
#'
#' # Pass model to function (labeled plot)
#' semPlotInteraction(
#'   data = states,
#'   fit = moderationFit,
#'   predictor = "Illiteracy",
#'   centered_predictor = "Illiteracy_centered",
#'   moderator = "Murder",
#'   centered_moderator = "Murder_centered",
#'   interaction = "interaction",
#'   outcome = "Income_rescaled",
#'   covariates = "HS.Grad",
#'   ignore = NULL,
#'   predStr = "Illiteracy Level",
#'   modStr = "Murder Rate",
#'   outStr = "Income")

semPlotInteraction <- function(data, fit, predictor, centered_predictor, moderator, centered_moderator, interaction, outcome, covariates = NULL, ignore = NULL, predStr = NULL, modStr = NULL, outStr = NULL) {

  # Create data template
  impliedData <- expand.grid(
    predictor_factor = c("Low", "Middle", "High"),
    moderator_factor = c("Low", "Middle", "High")
  )

  # Locate variable columns in existing data
  predCol <- match(predictor, names(data))
  modCol <- match(moderator, names(data))
  outCol <- match(outcome, names(data))

  # Get mean and sd of predictor and moderator
  predictor_mean <- mean(data[[predCol]], na.rm = TRUE)
  predictor_sd <- sd(data[[predCol]], na.rm = TRUE)
  moderator_mean <- mean(data[[modCol]], na.rm = TRUE)
  moderator_sd <- sd(data[[modCol]], na.rm = TRUE)

  # Get mean and sd of centered predictor and moderator
  predictor_centered_mean <- mean(scale(data[[predCol]], scale = FALSE), na.rm = TRUE)
  predictor_centered_sd <- sd(scale(data[[predCol]], scale = FALSE), na.rm = TRUE)
  moderator_centered_mean <- mean(scale(data[[modCol]], scale = FALSE), na.rm = TRUE)
  moderator_centered_sd <- sd(scale(data[[modCol]], scale = FALSE), na.rm = TRUE)

  # Compute predictor, moderator, and interaction term values
  predictorVal_centered <- moderatorVal_centered <- NULL

  impliedData <- impliedData |>
    mutate(
      predictorVal = case_when(
        predictor_factor == "Low" ~ predictor_mean - predictor_sd,
        predictor_factor == "Middle" ~ predictor_mean,
        predictor_factor == "High" ~ predictor_mean + predictor_sd
      ),
      moderatorVal = case_when(
        moderator_factor == "Low" ~ moderator_mean - moderator_sd,
        moderator_factor == "Middle" ~ moderator_mean,
        moderator_factor == "High" ~ moderator_mean + moderator_sd
      ),
      predictorVal_centered = case_when(
        predictor_factor == "Low" ~ predictor_centered_mean - predictor_centered_sd,
        predictor_factor == "Middle" ~ predictor_centered_mean,
        predictor_factor == "High" ~ predictor_centered_mean + predictor_centered_sd
      ),
      moderatorVal_centered = case_when(
        moderator_factor == "Low" ~ moderator_centered_mean - moderator_centered_sd,
        moderator_factor == "Middle" ~ moderator_centered_mean,
        moderator_factor == "High" ~ moderator_centered_mean + moderator_centered_sd
      ),
      interactionVal = predictorVal_centered * moderatorVal_centered,
      outcomeVal = NA
    )

  # Compute mean of covariates (if they are included in the model)
  if (!is.null(covariates)) {
    for (covariate in covariates) {
      covCol <- match(covariate, names(data))
      impliedData[[covariate]] <- mean(data[[covCol]], na.rm = TRUE)
    }
  }

  # Append NA columns for any model-included variables that are ignored for plotting purposes
  ignoreVars <- data.frame(matrix(ncol = length(ignore), nrow = nrow(impliedData)))
  impliedData <- cbind(impliedData, ignoreVars) %>% data.frame()
  
  # Rename columns for model-based calculations
  colnames(impliedData) <- c("predictor_factor", "moderator_factor", predictor, moderator, centered_predictor, centered_moderator, interaction, outcome, covariates, ignore)
  
  # Locate columns for calculations and plotting
  predCol_new <- match(predictor, names(impliedData))
  modCol_new <- match(moderator, names(impliedData))
  outCol_new <- match(outcome, names(impliedData))

  # Compute outcome using model
  impliedData[outCol_new] <- lavPredictY(
    fit,
    newdata = impliedData,
    ynames = outcome) |>
    as.vector()

  # Create labels
  moderator_labels <- factor(
    impliedData$moderator_factor,
    levels = c("High", "Middle", "Low"),
    labels = c("High (+1 SD)", "Middle (mean)", "Low (\u22121 SD)"))

  # Plot
  if(!is.null(modStr) & !is.null(predStr) & !is.null(outStr)){
    plot <- ggplot(
      data = impliedData,
      mapping = aes(
        x = impliedData[[predCol_new]],
        y = impliedData[[outCol_new]],
        color = moderator_labels)) +
      geom_line() +
      labs(color = modStr,
           x = predStr,
           y = outStr)
  }

  if(is.null(modStr) | is.null(predStr) | is.null(outStr)){
    plot <- ggplot(
      data = impliedData,
      mapping = aes(
        x = impliedData[[predCol_new]],
        y = impliedData[[outCol_new]],
        color = moderator_labels)) +
      geom_line() +
      labs(color = "Moderator",
           x = "Predictor",
           y = "Outcome")
  }

  return(plot)
}
