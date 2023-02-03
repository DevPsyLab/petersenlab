#' @title
#' Plot 2-way interaction.
#'
#' @description
#' Generates a plot of a 2-way interaction.
#'
#' @details
#' Generates a plot of a 2-way interaction: the association between a predictor
#' and an outcome at two levels of the moderator.
#'
#' @param predictor character name of predictor variable  (variable on x-axis).
#' @param outcome character name of outcome variable  (variable on y-axis).
#' @param moderator character name of moderator variable  (variable on z-axis).
#' @param predictorLabel label on x-axis of plot
#' @param outcomeLabel label on y-axis of plot
#' @param moderatorLabel label on z-axis of plot
#' @param varList names of predictor variables in model
#' @param varTypes types of predictor variables in model; one of:
#' \itemize{
#'  \item \code{"mean"} = plots at mean of variable -- should be used for ALL
#'  covariates (apart from main predictor and moderator)
#'  \item \code{"sd"} = plots at +/- 1 sd of variable (for most continuous
#'  predictors and moderators)
#'  \item \code{"binary"} = plots at values of 0,1 (for binary predictors and
#'  moderators)
#'  \item \code{"full"} = plots full range of variable (for variables like age
#'  when on x-axis)
#'  \item \code{"values"} = allows plotting moderator at specific values (e.g.,
#'  \code{0}, \code{1}, \code{2})
#'  \item \code{"factor"} = plots moderator at different categories (e.g.,
#'  \code{TRUE}, \code{FALSE})
#' }
#' @param values specifies values at which to plot moderator (must specify
#' varType = \code{"values"})
#' @param interaction one of:
#' \itemize{
#'  \item \code{"normal"} = standard interaction
#'  \item \code{"meancenter"} = calculates the interaction from a mean-centered
#'  predictor and moderator (subtracting each individual's value from the
#'  variable mean to set the mean of the variable to zero)
#'  \item \code{"orthogonalize"} = makes the interaction orthogonal to the
#'  predictor and moderator by regressing the interaction on the predictor and
#'  outcome and saving the residual
#' }
#' @param legendLabels vector of 2 labels for the two levels of the moderator;
#' leave as \code{NA} to see the actual levels of the moderator
#' @param legendLocation one of: \code{"topleft"}, \code{"topright"},
#' \code{"bottomleft"}, or \code{"bottomright"}
#' @param ylim vector of min and max values on y-axis (e,g., \code{0},
#' \code{10})
#' @param pvalues whether to include p-values of each slope in plot (\code{TRUE}
#' or \code{FALSE})
#' @param data name of data object
#'
#' @return
#' Plot of two-way interaction.
#'
#' @family plot
#'
#' @importFrom graphics lines text legend
#' @importFrom stats lm na.omit qnorm sd rnorm
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' predictor <- rnorm(1000, 10, 3)
#' moderator <- rnorm(1000, 50, 10)
#' outcome <- (1.7 * predictor) + (1.3 * moderator) +
#'   (1.5 * predictor * moderator) + rnorm(1000, sd = 3)
#' covariate <- rnorm(1000)
#' df <- data.frame(predictor, moderator, outcome, covariate)
#'
#' # Linear Regression
#' lmModel <- lm(outcome ~ predictor + moderator + predictor:moderator,
#'   data = df, na.action = "na.exclude")
#' summary(lmModel)
#'
#' # 1. Plot 2-Way Interaction
#' plot2WayInteraction(predictor = "predictor",
#'                     outcome = "outcome",
#'                     moderator = "moderator",
#'                     varList = c("predictor","moderator","covariate"),
#'                     varTypes = c("sd","binary","mean"),
#'                     data = df)
#'
#' # 2. Specify y-axis Range
#' plot2WayInteraction(predictor = "predictor",
#'                     outcome = "outcome",
#'                     moderator = "moderator",
#'                     varList = c("predictor","moderator","covariate"),
#'                     varTypes = c("sd","binary","mean"),
#'                     ylim = c(10,50),                                  #new
#'                     data = df)
#'
#' # 3. Add Variable Labels
#' plot2WayInteraction(predictor = "predictor",
#'                     outcome = "outcome",
#'                     moderator = "moderator",
#'                     varList = c("predictor","moderator","covariate"),
#'                     varTypes = c("sd","binary","mean"),
#'                     ylim = c(10,50),
#'                     predictorLabel = "Stress",                        #new
#'                     outcomeLabel = "Aggression",                      #new
#'                     moderatorLabel = "Gender",                        #new
#'                     data = df)
#'
#' # 4. Change Legend Labels
#' plot2WayInteraction(predictor = "predictor",
#'                     outcome = "outcome",
#'                     moderator = "moderator",
#'                     varList = c("predictor","moderator","covariate"),
#'                     varTypes = c("sd","binary","mean"),
#'                     ylim = c(10,50),
#'                     predictorLabel = "Stress",
#'                     outcomeLabel = "Aggression",
#'                     moderatorLabel = "Gender",
#'                     legendLabels = c("Boys","Girls"),                 #new
#'                     data = df)
#'
#' # 5. Move Legend Location
#' plot2WayInteraction(predictor = "predictor",
#'                     outcome = "outcome",
#'                     moderator = "moderator",
#'                     varList = c("predictor","moderator","covariate"),
#'                     varTypes = c("sd","binary","mean"),
#'                     ylim = c(10,50),
#'                     predictorLabel = "Stress",
#'                     outcomeLabel = "Aggression",
#'                     moderatorLabel = "Gender",
#'                     legendLabels = c("Boys","Girls"),
#'                     legendLocation = "topleft",                       #new
#'                     data = df)
#'
#' #6. Turn Off p-Values
#' plot2WayInteraction(predictor = "predictor",
#'                     outcome = "outcome",
#'                     moderator = "moderator",
#'                     varList = c("predictor","moderator","covariate"),
#'                     varTypes = c("sd","binary","mean"),
#'                     ylim = c(10,50),
#'                     predictorLabel = "Stress",
#'                     outcomeLabel = "Aggression",
#'                     moderatorLabel = "Gender",
#'                     legendLabels = c("Boys","Girls"),
#'                     legendLocation = "topleft",
#'                     pvalues = FALSE,                                  #new
#'                     data = df)
#'
#' #7. Get Regression Output from Mean-Centered Predictor and Moderator
#' plot2WayInteraction(predictor = "predictor",
#'                     outcome = "outcome",
#'                     moderator = "moderator",
#'                     varList = c("predictor","moderator","covariate"),
#'                     varTypes = c("sd","binary","mean"),
#'                     ylim = c(10,50),
#'                     predictorLabel = "Stress",
#'                     outcomeLabel = "Aggression",
#'                     moderatorLabel = "Gender",
#'                     legendLabels = c("Boys","Girls"),
#'                     legendLocation = "topleft",
#'                     interaction = "meancenter",                       #new
#'                     data = df)
#'
#' #8. Get Regression Output from Orthogonalized Interaction Term
#' plot2WayInteraction(predictor = "predictor",
#'                     outcome = "outcome",
#'                     moderator = "moderator",
#'                     varList = c("predictor","moderator","covariate"),
#'                     varTypes = c("sd","binary","mean"),
#'                     ylim = c(10,50),
#'                     predictorLabel = "Stress",
#'                     outcomeLabel = "Aggression",
#'                     moderatorLabel = "Gender",
#'                     legendLabels = c("Boys","Girls"),
#'                     legendLocation = "topleft",
#'                     interaction = "orthogonalize",                    #new
#'                     data = df)

# To-Do -------------------------------------------------------------------
#
# -Choose range on x-axis

plot2WayInteraction <- function(predictor, outcome, moderator, predictorLabel = "predictor", outcomeLabel = "outcome", moderatorLabel = "moderator", varList, varTypes, values = NA, interaction = "normal", legendLabels = NA, legendLocation = "topright", ylim = NA, pvalues = TRUE, data){
  varTypes <- varTypes[which(varList != outcome)]
  varList <- varList[which(varList != outcome)]

  #Specifies regression model
  product <- paste(predictor, moderator, sep = ":")
  modelData <- data[,unique(c(outcome, varList))]
  modelFormula <- as.formula(paste(paste(paste(outcome, predictor, sep = " ~ "), paste(unique(c(moderator, varList))[which(unique(c(moderator, varList)) != outcome & unique(c(moderator, varList)) != predictor)], collapse = ' + '),sep=" + "), paste(predictor, moderator, sep = ":"), sep = " + "))

  #Runs regression model
  model <- lm(formula = modelFormula, data = modelData, na.action = "na.omit")
  modelResults <- summary(model)

  #Regression output for calculating significance of slope
  predictorCoef <- coef(model)[names(coef(model)) == predictor]
  interactionCoef <- coef(model)[names(coef(model)) == product]
  varPredictorCoef <- vcov(model)[names(coef(model)) == predictor, names(coef(model)) == predictor]
  varInteractionCoef <- vcov(model)[names(coef(model)) == product, names(coef(model)) == product]
  covPredictorInteractionCoef <- vcov(model)[names(coef(model)) == predictor, names(coef(model)) == product]

  #Determine value(s) at which to plot each variable
  varValues <- list()
  for (i in 1:length(varList)){
    if(varTypes[i] == "mean"){
      varValues[[i]] <- mean(modelData[,varList[i]], na.rm = TRUE)
    } else if(varTypes[i]=="sd"){
      varValues[[i]] <- qnorm(pnorm(c(-1, 1)), mean = mean(modelData[,varList[i]], na.rm = TRUE), sd = sd(modelData[,varList[i]], na.rm = TRUE))
    } else if(varTypes[i] == "binary"){
      varValues[[i]] <- c(0,1)
    } else if(varTypes[i] == "full"){
      varValues[[i]] <- c(min(modelData[,varList[i]], na.rm = TRUE), max(modelData[,varList[i]], na.rm = TRUE))
    } else if(varTypes[i] == "values"){
      varValues[[i]] <- values
    } else if(varTypes[i] == "factor"){
      varValues[[i]] <- as.factor(unique(na.omit(modelData[,varList[i]])))
    }
  }
  names(varValues) <- varList

  #Combine each combination of values of predictor and moderator
  plotData <- expand.grid(varValues)

  #Calculate fitted values of outcome at various levels of the predictor and moderator
  plotData$outcome <- predict(model, newdata = plotData, level = 0)
  names(plotData) <- c(varList, outcome)
  numLines <- length(unique(plotData[,moderator]))

  #Specify data for each line
  plotLine1 <- NULL
  plotLine2 <- NULL
  for (i in 1:numLines){
    assign(paste("plotLine", i, sep = ""), plotData[plotData[,moderator] == unique(plotData[,moderator])[i],])

    #Calculate p-values for each line to test whether slope is different from zero
    moderatorValue <- unique(plotData[,moderator])[i]
    assign(paste("slope", i, sep = ""), predictorCoef + (interactionCoef*moderatorValue))
    assign(paste("SEslope", i, sep = ""), sqrt(varPredictorCoef + (moderatorValue^2)*(varInteractionCoef) + 2*moderatorValue*covPredictorInteractionCoef))
    assign(paste("tSlope", i, sep = ""), get(paste("slope", i, sep = "")) / get(paste("SEslope", i, sep = "")))
    assign(paste("dfSlope", i, sep = ""), model$df)
    assign(paste("pSlope", i, sep = ""), 2*pt(-abs(get(paste("tSlope", i, sep = ""))),df=get(paste("dfSlope", i, sep = ""))))
    #assign(paste("pSlope", i, sep = ""), round(get(paste("pSlope", i, sep = "")), 3))

    if(get(paste("pSlope", i, sep = "")) < .001){
      assign(paste("pSlope", i, sep = ""), as.character("< .001"))
    } else if(round(get(paste("pSlope", i, sep="")),3) <= .001){
      assign(paste("pSlope", i, sep = ""), as.character("= .001"))
    } else if(round(get(paste("pSlope", i, sep="")),3) > .001){
      assign(paste("pSlope", i, sep = ""), paste("= ", sub("0.", ".", as.character(round(get(paste("pSlope", i, sep = "")),3))), sep = ""))
    }

    #Get coordinates of line for plotting
    assign(paste("coordinates", i, sep = ""), get(paste("plotLine", i, sep = ""))[which.max(get(paste("plotLine", i, sep = ""))[,names(get(paste("plotLine", i, sep = ""))) == predictor]), names(get(paste("plotLine", i, sep = ""))) == predictor | names(get(paste("plotLine", i, sep=""))) == outcome])
    assign(paste("coordinates", i, sep = ""), unlist(c(get(paste("coordinates", i, sep=""))[1] - (1/20)*(max(get(paste("plotLine", i, sep = ""))[,names(get(paste("plotLine", i, sep="")))==predictor]) - min(get(paste("plotLine", i, sep = ""))[,names(get(paste("plotLine", i, sep = ""))) == predictor])),
                                                     get(paste("coordinates", i, sep=""))[2] - ((1/10)*(max(get(paste("plotLine", i, sep = ""))[,names(get(paste("plotLine", i, sep="")))==outcome]) - min(get(paste("plotLine", i, sep = ""))[,names(get(paste("plotLine", i, sep = ""))) == outcome])) + .15)
    )))
  }

  #Specify line characteristics (type and color)
  lty4 <- c(1,2,1,2)
  col4 <- c("black","black","gray","gray")

  #Use ylim values as range of y-axis (if provided), otherwise use min and max observed values of outcome as range of y-axis
  #Plot line 1
  if(is.na(ylim[1]) == TRUE){
    plot(plotLine1[,predictor], plotLine1[,outcome], lty = 1, lwd = 2, type = 'l', xlab = predictorLabel, ylab = outcomeLabel, ylim = c(min(plotData[,outcome]), max(plotData[,outcome])))
  } else if (is.na(ylim[1]) == FALSE){
    plot(plotLine1[,predictor], plotLine1[,outcome], lty = 1, lwd = 2, type = 'l', xlab = predictorLabel, ylab = outcomeLabel, ylim = ylim)
  }

  #Plot line 2
  lines(plotLine2[,predictor], plotLine2[,outcome], lty = 2, col = "black", lwd = 2)

  #Plot any additional lines
  if (numLines > 2){
    for (i in 3:numLines){
      lines(get(paste("plotLine", i, sep = ""))[,predictor], get(paste("plotLine", i, sep = ""))[,outcome], lty = lty4[i], col = col4[i], lwd = 2)
    }
  }

  #Plot p-values
  if (pvalues==TRUE){
    for (i in 1:numLines){
      text(get(paste("coordinates", i, sep = ""))[1], get(paste("coordinates", i, sep = ""))[2], substitute(paste(italic(p), " ", x, sep = ""), list(x = get(paste("pSlope", i, sep = "")))))
    }
  }

  #Plots legend based on location (if provided) and labels (if provided)
  if(is.na(legendLabels[1]) == FALSE){
    legend(legendLocation,legend=c(legendLabels[1:numLines]), lwd = rep(2,numLines), lty = lty4[1:numLines], col = col4[1:numLines], bty = "n")
  } else if(is.na(legendLabels[1]) == TRUE){
    legendLabels <- vector(mode = "character", length = numLines)
    for (i in 1:numLines){
      if(is.factor(get(paste("plotLine", i, sep=""))[,c(moderator)]) == FALSE){
        legendLabels[i] <- paste(moderatorLabel," = ",round(unique(get(paste("plotLine", i, sep=""))[,c(moderator)]),2), sep = "")
      } else if (is.factor(get(paste("plotLine", i, sep=""))[,c(moderator)]) == TRUE){
        legendLabels[i] <- unique(as.character(get(paste("plotLine", i, sep = ""))[,c(moderator)]))
      }
    }
    legend(legendLocation, legend = c(legendLabels[1:numLines]), lwd = rep(2,numLines), lty = lty4[1:numLines], col = col4[1:numLines], bty = "n")
  }

  #Calculate mean-centered or orthogonalized regression output (if provided)
  if(interaction == "meancenter"){
    modelDataMC <- modelData
    modelDataMC[,predictor] <- scale(modelDataMC[,predictor], center = TRUE, scale = FALSE)
    modelDataMC[,moderator] <- scale(modelDataMC[,moderator], center = TRUE, scale = FALSE)

    modelMC <- lm(formula = modelFormula, data = modelDataMC, na.action = "na.omit")
    modelMCResults <- summary(modelMC)
  } else if(interaction == "orthogonalize"){
    modelDataOrtho <- modelData
    modelDataOrtho[,"interaction"] <- modelDataOrtho[,predictor] * modelDataOrtho[,moderator]
    modelDataOrtho[,paste(predictor,moderator, sep = "X")] <- resid(lm(modelDataOrtho[,"interaction"] ~ modelDataOrtho[,predictor] + modelDataOrtho[,moderator], na.action = na.exclude))
    modelDataOrtho <- modelDataOrtho[,names(modelDataOrtho) != "interaction"]
    modelFormulaOrtho <-  as.formula(paste(paste(outcome, predictor, sep = " ~ "), paste(unique(c(moderator, names(modelDataOrtho)))[which(unique(c(moderator, names(modelDataOrtho))) != outcome & unique(c(moderator,names(modelDataOrtho))) != predictor)], collapse = ' + '), sep=" + "))

    modelOrtho <- lm(formula = modelFormulaOrtho, data = modelDataOrtho, na.action = "na.omit")
    modelOrthoResults <- summary(modelOrtho)
  }

  if(interaction == "normal"){
    return(modelResults)
  } else if(interaction == "meancenter"){
    return(modelMCResults)
  } else if(interaction == "orthogonalize"){
    return(modelOrthoResults)
  }
}
