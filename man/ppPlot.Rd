% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ppPlot.R
\name{ppPlot}
\alias{ppPlot}
\title{PP Plot.}
\usage{
ppPlot(model)
}
\arguments{
\item{model}{The model object of a linear regression model fit using the
\code{lm()} function.}
}
\value{
Normal probability (P-P) plot.
}
\description{
Normal Probability (P-P) Plot.
}
\details{
A normal probability (P-P) plot compares the empirical cumulative
distribution to the theoretical cumulative distribution.
}
\examples{
# Prepare Data
predictor1 <- rnorm(100)
predictor2 <- rnorm(100)
outcome <- rnorm(100)

# Fit Model
lmModel <- lm(outcome ~ predictor1 + predictor2)

# P-P Plot
ppPlot(lmModel)

}
\seealso{
\url{https://www.r-bloggers.com/2009/12/r-tutorial-series-graphic-analysis-of-regression-assumptions/}

Other plot: 
\code{\link{addText}()},
\code{\link{plot2WayInteraction}()},
\code{\link{semPlotInteraction}()},
\code{\link{vwReg}()}

Other multipleRegression: 
\code{\link{lmCombine}()},
\code{\link{plot2WayInteraction}()},
\code{\link{semPlotInteraction}()},
\code{\link{update_nested}()}
}
\concept{multipleRegression}
\concept{plot}
