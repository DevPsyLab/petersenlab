#' @title
#' Create Nomogram.
#'
#' @description
#' Create nomogram plot.
#'
#' @details
#' Create nomogram plot from the following at a given cut point:
#'
#' \itemize{
#'   \item 1) true positives (TP), true negatives (TN), false positives (FP),
#'   and false negatives (FN)
#'   \item 2) pretest probability (pretestProb), sensitivity (SN), and
#'   specificity (SP), OR
#'   \item 3) pretest probability (pretestProb), sensitivity (SN), and
#'   selection rate (selectionRate), OR
#'   \item 4) pretest probability (pretestProb), positive likelihood ratio
#'   (PLR), and negative likelihood ratio (NLR)
#' }
#'
#' @param TP Number of true positive cases.
#' @param TN Number of true negative cases.
#' @param FP Number of false positive cases.
#' @param FN Number of false negative cases.
#' @param pretestProb Pretest probability (prevalence/base rate/prior
#' probability) of characteristic, as a number between 0 and 1.
#' @param selectionRate Selection rate (marginal probability of positive test),
#' as a number between 0 and 1.
#' @param SN Sensitivity of the test at a given cut point, as a number
#' between 0 and 1.
#' @param SP Specificity of the test at a given cut point, as a number
#' between 0 and 1.
#' @param PLR Positive likelihood ratio of the test at a given cut point.
#' @param NLR Positive likelihood ratio of the test at a given cut point.
#' @param Detail If \code{TRUE}, overlay key statistics onto the plot.
#' @param NullLine If \code{TRUE}, add a line from prior prob through LR = 1.
#' @param LabelSize Label size.
#' @param Verbose Print out relevant metrics in the console.
#'
#' @return
#' ggplot object of nomogram plot.
#'
#' @family accuracy
#'
#' @importFrom ggplot2 theme_set theme_bw theme element_blank element_text
#' geom_line geom_vline annotate scale_x_continuous scale_y_continuous sec_axis
#' rel coord_cartesian
#' @importFrom scales percent
#'
#' @export
#'
#' @examples
#'
#' nomogrammer(
#'   TP = 253,
#'   TN = 386,
#'   FP = 14,
#'   FN = 347)
#'
#' nomogrammer(
#'   pretestProb = .60,
#'   SN = 0.421,
#'   SP = 0.965)
#'
#' nomogrammer(
#'   pretestProb = .60,
#'   SN = 0.421,
#'   selectionRate = 0.267)
#'
#' nomogrammer(
#'   pretestProb = .60,
#'   PLR = 12,
#'   NLR = 0.6)
#'
#' @seealso
#' \url{https://github.com/achekroud/nomogrammer}

## Create simple Fagan nomograms as ggplot objects
##   Adapted from: https://github.com/achekroud/nomogrammer
##   Based on Perl web-implementation (http://araw.mede.uic.edu/cgi-bin/testcalc.pl)
##   Authors: AM. Chekroud* & A. Schwartz (* adam dot chekroud at yale . edu)
##   December 2016

nomogrammer <- function(
    TP = NULL, TN = NULL, FP = NULL, FN = NULL,
    pretestProb = NULL,
    selectionRate = NULL,
    SN = NULL, SP = NULL,
    PLR = NULL, NLR = NULL,
    Detail = FALSE,
    NullLine = FALSE,
    LabelSize = (14/5),
    Verbose = FALSE){

  line <- lo_y <- x <- NULL

  ######################################
  ########## Libraries & Functions #####
  ######################################

  ## Helper functions
  ##   (defined inside nomogrammer, so remain local only & wont clutter user env)
  odds         <- function(p){
    # Function converts probability into odds
    o <- p/(1-p)
    return(o)
  }

  logodds      <- function(p){
    # Function returns logodds for a probability
    lo <- log10(p/(1-p))
    return(lo)
  }

  logodds_to_p <- function(lo){
    # Function goes from logodds back to a probability
    o <- 10^lo
    p <- o/(1+o)
    return(p)
  }

  p2percent <- function(p){
    # Function turns numeric probability into string percentage
    # e.g. 0.6346111 -> 63.5%
    scales::percent(signif(p, digits = 3))}


  ######################################
  ########## Calculations     ##########
  ######################################

  ## Checking inputs

  if(!missing(TP) & !missing(TN) & !missing(FP) & !missing(FN)){
    TPTNFPFN <- TRUE
  } else if (!missing(pretestProb) & !missing(SN) & !missing(SP)){
    SNSP <- TRUE
    TPTNFPFN <- FALSE
  } else if (!missing(pretestProb) & !missing(SN) & !missing(selectionRate)){
    SNSR <- TRUE
    TPTNFPFN <- FALSE
    SNSP <- FALSE
  } else if (!missing(pretestProb) & !missing(PLR) & !missing(NLR)){
    PLRNLR <- TRUE
    TPTNFPFN <- FALSE
    SNSP <- FALSE
    SNSR <- FALSE
  } else{
    stop("Missing arguments")
  }

  ## If TP, TN, FP, and FN provided, we calculate posterior probabilities & odds using TP, TN, FP, and FN
  ##  otherwise, if SN and SP are provided, we calculate posteriors using SN & SP
  ##  otherwise, if SN and selectionRate are provided, we calculate posteriors using SN & selectionRate
  ##  otherwise, if PLR and NLR provided, we calculate posteriors using PLR & NLR
  if(TPTNFPFN == TRUE){
    # TP/TN/FP/FN needs to be numeric
    if(!is.numeric(TP) | !is.numeric(TN) | !is.numeric(FP) | !is.numeric(FN)){stop("TP, TN, FP, and FN should be numeric")}

    # make sure TP, TN, FP, and FN are numbers
    if(!is.numeric(TP)){stop("TP should be numeric")}
    if(!is.numeric(TN)){stop("TN should be numeric")}
    if(!is.numeric(FP)){stop("FP should be numeric")}
    if(!is.numeric(FN)){stop("FN should be numeric")}

    prior_prob  <- (TP + FN)/(TP + TN + FP + FN)
    prior_odds  <- odds(prior_prob)
    sensitivity <- TP/(TP + FN)
    specificity <- TN/(TN + FP)
    PLR <- sensitivity/(1-specificity)
    NLR <- (1-sensitivity)/specificity
    post_odds_pos  <- prior_odds * PLR
    post_odds_neg  <- prior_odds * NLR
    post_prob_pos  <- post_odds_pos/(1+post_odds_pos)
    post_prob_neg  <- post_odds_neg/(1+post_odds_neg)
  } else if(SNSP == TRUE){
    # pretest prob needs to be numeric
    if(!is.numeric(pretestProb)){stop("Pretest probability should be numeric")}
    # pretest prob needs to be a prob not a percent
    if((pretestProb > 1) | (pretestProb <= 0)){stop("Pretest probability should be a probability (did you give a %?)")}

    # make sure SN and SP are numbers
    if(!is.numeric(SN)){stop("Sensitivity should be numeric")}
    if(!is.numeric(SP)){stop("Specificity should be numeric")}
    # make sure SN and SP are numbers that are probabilities not percentages
    if((SN > 1) | (SN <= 0)){stop("Sensitivity should be a probability (did you give a %?)")}
    if((SP > 1) | (SP <= 0)){stop("Specificity should be a probability (did you give a %?)")}

    prior_prob  <- pretestProb
    prior_odds  <- odds(prior_prob)
    sensitivity <- SN
    specificity <- SP
    PLR <- sensitivity/(1-specificity)
    NLR <- (1-sensitivity)/specificity
    post_odds_pos  <- prior_odds * PLR
    post_odds_neg  <- prior_odds * NLR
    post_prob_pos  <- post_odds_pos/(1+post_odds_pos)
    post_prob_neg  <- post_odds_neg/(1+post_odds_neg)
  } else if(SNSR == TRUE){
    # pretest prob needs to be numeric
    if(!is.numeric(pretestProb)){stop("Pretest probability should be numeric")}
    # pretest prob needs to be a prob not a percent
    if((pretestProb > 1) | (pretestProb <= 0)){stop("Pretest probability should be a probability (did you give a %?)")}

    # make sure SN and selectionRate are numbers
    if(!is.numeric(SN)){stop("Sensitivity should be numeric")}
    if(!is.numeric(selectionRate)){stop("Selection Rate should be numeric")}
    # make sure SN and selectionRate are numbers that are probabilities not percentages
    if((SN > 1) | (SN <= 0)){stop("Sensitivity should be a probability (did you give a %?)")}
    if((selectionRate > 1) | (selectionRate <= 0)){stop("Selection Rate should be a probability (did you give a %?)")}

    prior_prob  <- pretestProb
    prior_odds  <- odds(prior_prob)
    sensitivity <- SN
    specificity <- 1 - ((selectionRate - SN * pretestProb) / (1 - pretestProb))
    PLR <- sensitivity/(1-specificity)
    NLR <- (1-sensitivity)/specificity
    post_odds_pos  <- prior_odds * PLR
    post_odds_neg  <- prior_odds * NLR
    post_prob_pos  <- post_odds_pos/(1+post_odds_pos)
    post_prob_neg  <- post_odds_neg/(1+post_odds_neg)
  } else if(PLRNLR == TRUE){
    # pretest prob needs to be numeric
    if(!is.numeric(pretestProb)){stop("Pretest probability should be numeric")}
    # pretest prob needs to be a prob not a percent
    if((pretestProb > 1) | (pretestProb <= 0)){stop("Pretest probability should be a probability (did you give a %?)")}

    # make sure PLR and NLR are numbers
    if(!is.numeric(PLR)){stop("PLR should be numeric")}
    if(!is.numeric(NLR)){stop("NLR should be numeric")}
    # make sure PLR and NLR are numbers that vaguely make sense
    if(PLR < 1){stop("PLR shouldn't be less than 1")}
    if(NLR < 0){stop("NLR shouldn't be below zero")}
    if(NLR > 1){stop("NLR shouldn't be more than 1")}

    prior_prob  <- pretestProb
    prior_odds  <- odds(prior_prob)
    PLR <- PLR
    NLR <- NLR
    sensitivity <- (PLR*(1-NLR))/(PLR-NLR)    ## TODO: check Adam's math!
    specificity <- (1-PLR)/(NLR-PLR)          ## TODO: check Adam's math!
    post_odds_pos  <- prior_odds * PLR
    post_odds_neg  <- prior_odds * NLR
    post_prob_pos  <- post_odds_pos/(1+post_odds_pos)
    post_prob_neg  <- post_odds_neg/(1+post_odds_neg)
  } else{
    stop("Couldn't find SN & SP, or positive & negative likelihood ratios")
  }



  ######################################
  ########## Plotting (prep)  ##########
  ######################################


  ## Set common theme preferences up front
  theme_set(theme_bw() +
              theme(axis.text.x = element_blank(),
                    axis.ticks.x = element_blank(),
                    axis.title.x = element_blank(),
                    axis.title.y = element_text(angle = 0),
                    axis.title.y.right = element_text(angle = 0),
                    axis.line = element_blank(),
                    panel.grid = element_blank(),
                    legend.title=element_blank()#,
                    #legend.position = "none"
              )
  )

  ## Setting up the points of interest along the y-axes

  # Select probabilities of interest (nb as percentages)
  ticks_prob    <- c(0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 30,
                     40, 50, 60, 70, 80, 90, 95, 99)
  # Convert % to odds
  ticks_odds    <- odds(ticks_prob/100)
  # Convert % to logodds
  ticks_logodds <- logodds(ticks_prob/100)

  # Select the likelihood ratios of interest (for the middle y-axis)
  ticks_lrs     <- sort(c(10^(-3:3), 2*(10^(-3:2)), 5*(10^(-3:2))))
  # Log10 them since plot is in logodds space
  ticks_log_lrs <- log10(ticks_lrs)




  ## Fixing particular x-coordinates
  left     <- 0
  right    <- 1
  middle   <- 0.5
  midright <- 0.75

  ## Lay out the four key plot points
  ##  (the start and finish of the positive and negative lines)

  # Initially these are expressed as probabilities
  df <- data.frame(x=c(left, right, left, right),
                   y=c(prior_prob, post_prob_pos, prior_prob, post_prob_neg),
                   line = c("positive test", "positive test", "negative test", "negative test"))

  adj_min      <- range(ticks_logodds)[1]
  adj_max      <- range(ticks_logodds)[2]
  adj_diff     <- adj_max - adj_min
  scale_factor <- abs(adj_min) - adj_diff/2
  #df$lo_y <- ifelse(df$x==left,(10/adj_diff)*logodds(1-df$y)-1,logodds(df$y))

  # Convert probabilities to logodds for plotting
  df$lo_y  <- ifelse(df$x==left,logodds(1-df$y)-scale_factor,logodds(df$y))
  # zero         <- data.frame(x = c(left,right),
  #                            y = c(0,0),
  #                            line = c('pos','pos'),
  #                            lo_y = c(-scale_factor,0))





  rescale   <- range(ticks_logodds) + abs(adj_min) - adj_diff/2
  rescale_x_breaks  <- ticks_logodds + abs(adj_min) - adj_diff/2



  ######################################
  ########## Plot             ##########
  ######################################


  p <- ggplot(df) +
    geom_line(aes(x = x, y = lo_y, color = line), linewidth = 1) +
    geom_vline(xintercept = middle) +
    annotate(geom = "text",
             x = rep(middle+.075, length(ticks_log_lrs)),
             y = (ticks_log_lrs-scale_factor)/2,
             label = ticks_lrs,
             size = rel(LabelSize)) +
    annotate(geom="point",
             x = rep(middle, length(ticks_log_lrs)),
             y = (ticks_log_lrs-scale_factor)/2,
             size = 1) +
    annotate(geom = "text",
             x = middle,
             y = adj_max,
             label = "likelihood ratio") +
    scale_x_continuous(expand = c(0,0)) +
    coord_cartesian(ylim = rescale) +
    scale_y_continuous(expand = c(0,0),
                       breaks = -rescale_x_breaks,
                       labels = ticks_prob,
                       name = "prior \n prob.",
                       sec.axis = sec_axis(transform = ~.,
                                           name = "posterior \n prob.",
                                           labels = ticks_prob,
                                           breaks = ticks_logodds))

  ## Optional overlay text: pretestProb, PLR/NLR, and posterior probabilities
  detailedAnnotation <- paste(
    paste0("base rate = ", p2percent(prior_prob)),
    paste("PLR =", signif(PLR, 3),", NLR =", signif(NLR, 3)),
    paste("post. pos =", p2percent(post_prob_pos),
          ", neg =", p2percent(post_prob_neg)),
    sep = "\n")


  ## Optional amendments to the plot

  ## Do we add the null line i.e. LR = 1, illustrating an uninformative model
  if(NullLine == TRUE){
    ## If yes, first calculate the start and end points
    uninformative <- data.frame(
      x = c(left,right),
      lo_y = c( (logodds(1-prior_prob) - scale_factor) , logodds(prior_prob))
    )

    p <- p + geom_line(aes(x = x, y = lo_y), data = uninformative,
                       color = "gray",
                       lty = 2,
                       inherit.aes = FALSE)
  }


  ## Do we add the detailed stats to the top right?
  if(Detail == TRUE){
    p <- p + annotate(geom = "text",
                      x = midright,
                      y = 2,
                      label = detailedAnnotation,
                      size = rel(LabelSize))
  }

  if(Verbose == TRUE){
    writeLines(
      text = c(
        paste0("base rate = ", p2percent(prior_prob)),
        paste("PLR =", signif(PLR, 3)),
        paste("NLR =", signif(NLR, 3)),
        paste("posterior probability (positive) =", p2percent(post_prob_pos)),
        paste("posterior probability (negative) =", p2percent(post_prob_neg)),
        paste("sensitivity =", p2percent(sensitivity)),
        paste("specificity =", p2percent(specificity))
        # sep = "\n"
      )
    )
  }

  return(p)

}
