#' @title
#' Simulate Indirect Effect.
#'
#' @description
#' Simulate indirect effect from mediation analyses.
#'
#' @details
#' Co-created by Robert G. Moulder Jr. and Isaac T. Petersen
#'
#' @param N Sample size.
#' @param x Vector for the predictor variable.
#' @param m Vector for the mediating variable.
#' @param XcorM Coefficient of the correlation between the predictor variable
#' and mediating variable.
#' @param McorY Coefficient of the correlation between the mediating variable
#' and outcome variable.
#' @param corTotal Size of total effect.
#' @param proportionMediated The proportion of the total effect that is mediated.
#' @param seed Seed for replicability.
#'
#' @return
#' \itemize{
#'   \item the correlation between the predictor variable (\code{x}) and the
#'   mediating variable (\code{m}).
#'   \item the correlation between the mediating variable (\code{m}) and the
#'   outcome variable (\code{Y}).
#'   \item the correlation between the predictor variable (\code{x}) and the
#'   outcome variable (\code{Y}).
#'   \item the direct correlation between the predictor variable (\code{x}) and
#'   the outcome variable (\code{Y}), while controlling for the mediating
#'   variable (\code{m}).
#'   \item the indirect correlation between the predictor variable (\code{x})
#'   and the outcome variable (\code{Y}) through the mediating variable
#'   (\code{m}).
#'   \item the total correlation between the predictor variable (\code{x}) and
#'   the outcome variable (\code{Y}): i.e., the sum of the direct correlation
#'   and the indirect correlation.
#'   \item the proportion of the correlation between the predictor variable
#'   (\code{x}) and the outcome variable (\code{Y}) that is mediated through the
#'   mediating variable (\code{m}).
#' }
#'
#' @family simulation
#'
#' @export
#'
#' @importFrom mvtnorm rmvnorm
#' @importFrom stats lm rnorm sd
#'
#' @examples
#' #INSERT

simulateIndirectEffect <- function(N = NA, x = NA, m = NA, XcorM = NA, McorY = NA, corTotal = NA, proportionMediated = NA, seed = NA){
  if(!is.na(seed)){
    set.seed(seed)
  }

  if((!is.na(x[1]) | !is.na(m[1])) & !is.na(N)){
    stop("N must be NA if x or m provided")
  }

  if(!is.na(x[1]) & !is.na(m[1])){
    stop("Only x or m may be specified")
  }

  if(!is.na(XcorM) & !is.na(McorY) & !is.na(corTotal) & !is.na(proportionMediated)){
    stop("Either XcorM, McorY, corTotal, or proportionMediated must be NA")
  }

  # if(is.na(x[1]) & is.na(m[1]) & sum(is.na(XcorM) + is.na(McorY) + is.na(corTotal) + is.na(proportionMediated)>=2)){
  #   stop("Only one of XcorM, McorY, corTotal, or proportionMediated can be NA at a time")
  # }

  if(!is.na(x[1]) & !is.na(m[1]) & sum(is.na(McorY) + is.na(corTotal) + is.na(proportionMediated)>=2)){
    stop("Only one of McorY, corTotal, or proportionMediated can be NA at a time")
  }

  # No Data
  if(is.na(x[1]) & is.na(m[1])){

    if(is.na(N)){
      stop("Please specify N or provide data vector for x or m")
    }

    # No data - No proportionMediated
    if(!is.na(XcorM) & !is.na(McorY) & is.na(proportionMediated) & !is.na(corTotal)){

      if(corTotal < abs(XcorM*McorY)){
        stop("Absolute indirect effect |XcorM*McorY| must be less than total effect (corTotal)")
      }

      proportionMediated <- (XcorM*McorY)/corTotal
      directEffect <- corTotal - (XcorM*McorY)
      xmy <- rmvnorm(N, mean = c(0,0,0), sigma = matrix(c(1,XcorM,directEffect+(McorY*XcorM),
                                                          XcorM,1,McorY+(directEffect*XcorM),
                                                          directEffect+(McorY*XcorM),McorY+(directEffect*XcorM),1),
                                                        ncol = 3,
                                                        nrow = 3,
                                                        byrow=TRUE))
      xmy <- data.frame(xmy)
      colnames(xmy) <- c("X","M","Y")
    }

    # No data - No corTotal
    if(!is.na(XcorM) & !is.na(McorY) & !is.na(proportionMediated) & is.na(corTotal)){

      if(proportionMediated < abs(XcorM*McorY)){
        stop("Absolute indirect effect |XcorMa*McorY| must be less than proportion mediated")
      }

      corTotal <- (XcorM*McorY)/proportionMediated
      directEffect <- corTotal - (XcorM*McorY)
      xmy <- rmvnorm(N, mean = c(0,0,0), sigma = matrix(c(1,XcorM,directEffect+(McorY*XcorM),
                                                          XcorM,1,McorY+(directEffect*XcorM),
                                                          directEffect+(McorY*XcorM),McorY+(directEffect*XcorM),1),
                                                        ncol = 3,
                                                        nrow = 3,
                                                        byrow=TRUE))
      xmy <- data.frame(xmy)
      colnames(xmy) <- c("X","M","Y")
    }

    # No data - No McorY
    if(!is.na(XcorM) & is.na(McorY) & !is.na(proportionMediated) & !is.na(corTotal)){

      McorY <- (corTotal*proportionMediated)/XcorM
      directEffect <- corTotal - (XcorM*McorY)
      xmy <- rmvnorm(N, mean = c(0,0,0), sigma = matrix(c(1,XcorM,directEffect+(McorY*XcorM),
                                                          XcorM,1,McorY+(directEffect*XcorM),
                                                          directEffect+(McorY*XcorM),McorY+(directEffect*XcorM),1),
                                                        ncol = 3,
                                                        nrow = 3,
                                                        byrow=TRUE))
      xmy <- data.frame(xmy)
      colnames(xmy) <- c("X","M","Y")
    }

    # No data - No XcorM
    if(is.na(XcorM) & !is.na(McorY) & !is.na(proportionMediated) & !is.na(corTotal)){

      XcorM <- (corTotal*proportionMediated)/McorY
      directEffect <- corTotal - (XcorM*McorY)
      xmy <- rmvnorm(N, mean = c(0,0,0), sigma = matrix(c(1,XcorM,directEffect+(McorY*XcorM),
                                                          XcorM,1,McorY+(directEffect*XcorM),
                                                          directEffect+(McorY*XcorM),McorY+(directEffect*XcorM),1),
                                                        ncol = 3,
                                                        nrow = 3,
                                                        byrow=TRUE))
      xmy <- data.frame(xmy)
      colnames(xmy) <- c("X","M","Y")
    }

    # No data - No XcorM & XcorM
    if(is.na(XcorM) & is.na(McorY) & !is.na(proportionMediated) & !is.na(corTotal)){

      XcorM <- sqrt(corTotal*proportionMediated)
      McorY <- XcorM
      directEffect <- corTotal - (XcorM*McorY)
      xmy <- rmvnorm(N, mean = c(0,0,0), sigma = matrix(c(1,XcorM,directEffect+(McorY*XcorM),
                                                          XcorM,1,McorY+(directEffect*XcorM),
                                                          directEffect+(McorY*XcorM),McorY+(directEffect*XcorM),1),
                                                        ncol = 3,
                                                        nrow = 3,
                                                        byrow=TRUE))
      xmy <- data.frame(xmy)
      colnames(xmy) <- c("X","M","Y")
    }

  }

  # x Data
  if(!is.na(x[1]) & is.na(m[1])){

    N <- length(x)

    # x data - No proportionMediated
    if(!is.na(XcorM) & !is.na(McorY) & is.na(proportionMediated) & !is.na(corTotal)){


      proportionMediated <- (XcorM*McorY)/corTotal
      directEffect <- corTotal - (XcorM*McorY)

      x_std <-((x-mean(x))/sd(x))

      m <- XcorM*x_std + rnorm(N,0,1-XcorM^2)
      y <- directEffect*x_std + McorY*m + rnorm(N,0,1-directEffect^2-McorY^2)
      m <- m*sd(x)+mean(x)
      y <- y*sd(x)+mean(x)

      xmy <- data.frame(x,m,y)
      colnames(xmy) <- c("X","M","Y")

    }

    # x data - No corTotal
    if(!is.na(XcorM) & !is.na(McorY) & !is.na(proportionMediated) & is.na(corTotal)){


      corTotal <- (XcorM*McorY)/proportionMediated
      directEffect <- corTotal - (XcorM*McorY)

      x_std <-((x-mean(x))/sd(x))

      m <- XcorM*x_std + rnorm(N,0,1-XcorM^2)
      y <- directEffect*x_std + McorY*m + rnorm(N,0,1-directEffect^2-McorY^2)
      m <- m*sd(x)+mean(x)
      y <- y*sd(x)+mean(x)

      xmy <- data.frame(x,m,y)
      colnames(xmy) <- c("X","M","Y")
    }

    # x data - No McorY
    if(!is.na(XcorM) & is.na(McorY) & !is.na(proportionMediated) & !is.na(corTotal)){
      if(abs(corTotal*proportionMediated) > abs(XcorM)){
        stop("Absolute indirect effect |corTotal*proportionMediated| must be less than XcorM")
      }
      McorY <- (corTotal*proportionMediated)/XcorM
      directEffect <- corTotal - (XcorM*McorY)

      x_std <-((x-mean(x))/sd(x))

      m <- XcorM*x_std + rnorm(N,0,1-XcorM^2)
      y <- directEffect*x_std + McorY*m + rnorm(N,0,1-directEffect^2-McorY^2)
      m <- m*sd(x)+mean(x)
      y <- y*sd(x)+mean(x)

      xmy <- data.frame(x,m,y)
      colnames(xmy) <- c("X","M","Y")
    }

    # x data - No XcorM
    if(is.na(XcorM) & !is.na(McorY) & !is.na(proportionMediated) & !is.na(corTotal)){
      if(abs(corTotal*proportionMediated) > abs(McorY)){
        stop("Absolute indirect effect |corTotal*proportionMediated| must be less than McorY")
      }
      XcorM <- (corTotal*proportionMediated)/McorY
      directEffect <- corTotal - (XcorM*McorY)

      x_std <-((x-mean(x))/sd(x))

      m <- XcorM*x_std + rnorm(N,0,1-XcorM^2)
      y <- directEffect*x_std + McorY*m + rnorm(N,0,1-directEffect^2-McorY^2)
      m <- m*sd(x)+mean(x)
      y <- y*sd(x)+mean(x)

      xmy <- data.frame(x,m,y)
      colnames(xmy) <- c("X","M","Y")
    }

    # x data - No XcorM & XcorM
    if(is.na(XcorM) & is.na(McorY) & !is.na(proportionMediated) & !is.na(corTotal)){

      XcorM <- sqrt(corTotal*proportionMediated)
      McorY <- XcorM
      directEffect <- corTotal - (XcorM*McorY)

      x_std <-((x-mean(x))/sd(x))

      m <- XcorM*x_std + rnorm(N,0,1-XcorM^2)
      y <- directEffect*x_std + McorY*m + rnorm(N,0,1-directEffect^2-McorY^2)
      m <- m*sd(x)+mean(x)
      y <- y*sd(x)+mean(x)

      xmy <- data.frame(x,m,y)
      colnames(xmy) <- c("X","M","Y")
    }

  }


  # M Data
  if(is.na(x[1]) & !is.na(m[1])){

    N <- length(m)

    # C data - No proportionMediated
    if(!is.na(XcorM) & !is.na(McorY) & is.na(proportionMediated) & !is.na(corTotal)){


      proportionMediated <- (XcorM*McorY)/corTotal
      directEffect <- corTotal - (XcorM*McorY)

      m_std <-((m-mean(m))/sd(m))

      x <- XcorM*m_std + rnorm(N,0,1-XcorM^2)
      y <- directEffect*x + McorY*m_std + rnorm(N,0,1-directEffect^2-McorY^2)
      x <- x*sd(m)+mean(m)
      y <- y*sd(m)+mean(m)

      xmy <- data.frame(x,m,y)
      colnames(xmy) <- c("X","M","Y")

    }

    # V data - No corTotal
    if(!is.na(XcorM) & !is.na(McorY) & !is.na(proportionMediated) & is.na(corTotal)){


      corTotal <- (XcorM*McorY)/proportionMediated
      directEffect <- corTotal - (XcorM*McorY)

      m_std <-((m-mean(m))/sd(m))

      x <- XcorM*m_std + rnorm(N,0,1-XcorM^2)
      y <- directEffect*x + McorY*m_std + rnorm(N,0,1-directEffect^2-McorY^2)
      x <- x*sd(m)+mean(m)
      y <- y*sd(m)+mean(m)

      xmy <- data.frame(x,m,y)
      colnames(xmy) <- c("X","M","Y")
    }

    # V data - No McorY
    if(!is.na(XcorM) & is.na(McorY) & !is.na(proportionMediated) & !is.na(corTotal)){
      if(abs(corTotal*proportionMediated) > abs(XcorM)){
        stop("Absolute indirect effect |corTotal*proportionMediated| must be less than XcorM")
      }
      McorY <- (corTotal*proportionMediated)/XcorM
      directEffect <- corTotal - (XcorM*McorY)

      m_std <-((m-mean(m))/sd(m))

      x <- XcorM*m_std + rnorm(N,0,1-XcorM^2)
      y <- directEffect*x + McorY*m_std + rnorm(N,0,1-directEffect^2-McorY^2)
      x <- x*sd(m)+mean(m)
      y <- y*sd(m)+mean(m)

      xmy <- data.frame(x,m,y)
      colnames(xmy) <- c("X","M","Y")
    }

    # V data - No XcorM
    if(is.na(XcorM) & !is.na(McorY) & !is.na(proportionMediated) & !is.na(corTotal)){
      if(abs(corTotal*proportionMediated) > abs(McorY)){
        stop("Absolute indirect effect |corTotal*proportionMediated| must be less than McorY")
      }
      XcorM <- (corTotal*proportionMediated)/McorY
      directEffect <- corTotal - (XcorM*McorY)

      m_std <-((m-mean(m))/sd(m))

      x <- XcorM*m_std + rnorm(N,0,1-XcorM^2)
      y <- directEffect*x + McorY*m_std + rnorm(N,0,1-directEffect^2-McorY^2)
      x <- x*sd(m)+mean(m)
      y <- y*sd(m)+mean(m)

      xmy <- data.frame(x,m,y)
      colnames(xmy) <- c("X","M","Y")
    }

    # V data - No XcorM & XcorM
    if(is.na(XcorM) & is.na(McorY) & !is.na(proportionMediated) & !is.na(corTotal)){

      XcorM <- sqrt(corTotal*proportionMediated)
      McorY <- XcorM
      directEffect <- corTotal - (XcorM*McorY)

      m_std <-((m-mean(m))/sd(m))

      x <- XcorM*m_std + rnorm(N,0,1-XcorM^2)
      y <- directEffect*x + McorY*m_std + rnorm(N,0,1-directEffect^2-McorY^2)
      x <- x*sd(m)+mean(m)
      y <- y*sd(m)+mean(m)

      xmy <- data.frame(x,m,y)
      colnames(xmy) <- c("X","M","Y")
    }

  }

  res <- list(NA,NA,NA)
  names(res) <- c("simulatedData", "theoreticalParameters", "empiricalParameters")
  res$simulatedData <- xmy
  res$theoreticalParameters <- matrix(c(XcorM,McorY,directEffect,XcorM*McorY,corTotal,proportionMediated),
                                      nrow = 6,
                                      ncol = 1)
  colnames(res$theoreticalParameters) <- "Value"
  rownames(res$theoreticalParameters) <- c("cor(X,M)",
                                           "cor(M,Y)",
                                           "Direct Correlation",
                                           "Indirect Correlation",
                                           "Total Correlation",
                                           "Proportion Mediated")
  mod1 <- lm(M ~ X, data = xmy)
  mod2 <- lm(Y ~ X + M, data = xmy)
  res$empiricalParameters <- matrix(c(cor(xmy$X,xmy$M),
                                      cor(xmy$Y,xmy$M),
                                      cor(xmy$X,xmy$Y),
                                      mod2$coefficients[2],
                                      mod1$coefficients[2]*mod2$coefficients[3],
                                      mod2$coefficients[2] + mod1$coefficients[2]*mod2$coefficients[3],
                                      (mod1$coefficients[2]*mod2$coefficients[3])/(mod2$coefficients[2] + mod1$coefficients[2]*mod2$coefficients[3])),
                                    nrow = 7,
                                    ncol = 1)
  colnames(res$empiricalParameters) <- "Value"
  rownames(res$empiricalParameters) <- c("cor(X,M)",
                                         "cor(M,Y)",
                                         "cor(X,Y)",
                                         "Direct Correlation",
                                         "Indirect Correlation",
                                         "Total Correlation",
                                         "Proportion Mediated")
  return(res)
}
