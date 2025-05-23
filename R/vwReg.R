# Adapted from 2012 code from Felix Schönbrodt:
# Copyright 2012 Felix Schönbrodt
# All rights reserved.
#
# FreeBSD License
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER `AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# The views and conclusions contained in the software and documentation
# are those of the authors and should not be interpreted as representing
# official policies, either expressed or implied, of the copyright
# holder.
#
# Version history:
# 0.1: original code
# 0.1.1: changed license to FreeBSD; re-established compatability to ggplot2
# (new version 0.9.2)
#
## Visually weighted regression / Watercolor plots
## Idea: Solomon Hsiang, with additional ideas from many blog commenters
#
#' @title
#' Visually Weighted Regression.
#'
#' @description
#' Create watercolor plot to visualize weighted regression.
#'
#' @details
#' Creates a watercolor plot to visualize weighted regression.
#'
#' @param formula regression model.
#' @param data dataset.
#' @param title plot title.
#' @param B number of bootstrapped smoothers.
#' @param shade whether to plot the shaded confidence region.
#' @param shade.alpha whether to fade out the confidence interval shading at
#' the edges (by reducing alpha; 0 = no alpha decrease, 0.1 = medium alpha
#' decrease, 0.5 = strong alpha decrease).
#' @param spag whether to plot spaghetti lines.
#' @param spag.color color of spaghetti lines.
#' @param mweight logical indicating whether to make the median smoother
#' visually weighted.
#' @param show.lm logical indicating whether to plot the linear regression line.
#' @param show.CI logical indicating whether to plot the 95\% confidence
#' interval limits.
#' @param show.median logical indicating whether to plot the median smoother.
#' @param median.col color of the median smoother.
#' @param shape shape of points.
#' @param method color of spaghetti lines.
#' @param spag.color the fitting function for the spaghettis; default:
#' \code{loess}.
#' @param bw logical indicating whether to use a b&w palette; default:
#' \code{TRUE}.
#' @param slices number of slices in x and y direction for the shaded region.
#' Higher numbers make a smoother plot, but takes longer to draw. I would not
#' set \code{slices} to more than 500.
#' @param palette provide a custom color palette for the watercolors.
#' @param ylim restrict range of the watercoloring.
#' @param quantize either \code{continuous}, or \code{SD}. In the latter case, we get
#' three color regions for 1, 2, and 3 SD (an idea of John Mashey).
#' @param add if \code{add == FALSE}, a new ggplot is returned. If
#' \code{add == TRUE}, only the elements are returned, which can be added to an
#' existing ggplot (with the \code{+} operator).
#' @param ... further parameters passed to the fitting function, in the case of
#' loess, for example, \code{span = .9}, or \code{family = "symmetric"}.
#'
#' @return plot
#'
#' @family plot
#' @family correlations
#'
#' @importFrom grDevices colorRampPalette
#' @importFrom plyr adply ddply .
#' @importFrom reshape2 melt
#' @importFrom ggplot2 ggplot theme_bw geom_tile scale_fill_gradientn
#' scale_alpha_continuous geom_polygon geom_path aes geom_smooth geom_point
#' theme labs sym
#' @importFrom RColorBrewer brewer.pal
#' @importFrom utils flush.console
#' @importFrom viridisLite viridis
#' @importFrom stats predict lm quantile na.omit loess.control pnorm density rnorm loess
#'
#' @export
#'
#' @examples
#'\donttest{
#' # Prepare Data
#' data("mtcars")
#' df <- data.frame(x = mtcars$hp, y = mtcars$mpg)
#'
#' ## Visually Weighted Regression
#'
#' # Default
#' vwReg(y ~ x, df)
#'
#' # Shade
#' vwReg(y ~ x, df, shade = TRUE, show.lm = TRUE, show.CI = TRUE,
#' quantize = "continuous")
#' vwReg(y ~ x, df, shade = TRUE, show.lm = TRUE, show.CI = TRUE,
#' quantize = "SD")
#'
#' # Spaghetti
#' vwReg(y ~ x, df, shade = FALSE, spag = TRUE, show.lm = TRUE, show.CI = TRUE)
#' vwReg(y ~ x, df, shade = FALSE, spag = TRUE)
#'
#' # Black/white
#' vwReg(y ~ x, df, shade = TRUE, spag = FALSE, show.lm = TRUE, show.CI = TRUE,
#' bw = TRUE, quantize = "continuous")
#' vwReg(y ~ x, df, shade = TRUE, spag = FALSE, show.lm = TRUE, show.CI = TRUE,
#' bw = TRUE, quantize = "SD")
#' vwReg(y ~ x, df, shade = FALSE, spag = TRUE, show.lm = TRUE, show.CI = TRUE,
#' bw = TRUE, quantize = "SD")
#'
#' # Change the bootstrap smoothing
#' vwReg(y ~ x, df, family = "symmetric") # use an M-estimator for
#' # bootstrap smoothers. Usually yields wider confidence intervals
#' vwReg(y ~ x, df, span = 1.7) # increase the span of the smoothers
#' vwReg(y ~ x, df, span = 0.5) # decrease the span of the smoothers
#'
#' # Change the color scheme
#' vwReg(y ~ x, df, palette = viridisLite::viridis(4)) # viridis
#' vwReg(y ~ x, df, palette = viridisLite::magma(4)) # magma
#' vwReg(y ~ x, df, palette = RColorBrewer::brewer.pal(9, "YlGnBu")) # change the
#' # color scheme, using a predefined ColorBrewer palette. You can see all
#' # available palettes by using this command:
#' # `library(RColorBrewer); display.brewer.all()`
#' vwReg(y ~ x, df, palette = grDevices::colorRampPalette(c("white","yellow",
#' "green","red"))(20)) # use a custom-made palette
#' vwReg(y ~ x, df, palette = grDevices::colorRampPalette(c("white","yellow",
#' "green","red"), bias = 3)(20)) # use a custom-made palette, with the
#' # parameter bias you can shift the color ramp to the “higher” colors
#' vwReg(y ~ x, df, bw = TRUE) # black and white version
#' vwReg(y ~ x, df, shade.alpha = 0, palette = grDevices::colorRampPalette(
#' c("black","grey30","white"), bias = 4)(20)) # Milky-Way Plot
#' vwReg(y ~ x, df, shade.alpha = 0, slices = 400, palette =
#' grDevices::colorRampPalette(c("black","green","yellow","red"),
#' bias = 5)(20), family = "symmetric") # Northern Light Plot/ fMRI plot
#' vwReg(y ~ x, df, quantize = "SD") # 1-2-3-SD plot
#' }
#'
#' @seealso
#' \url{https://web.archive.org/web/20250113033713/https://www.nicebread.de/visually-weighted-regression-in-r-a-la-solomon-hsiang/}
#'
#' \url{https://web.archive.org/web/20250113022046/https://www.nicebread.de/visually-weighted-watercolor-plots-new-variants-please-vote/}
#'
#' \url{http://www.fight-entropy.com/2012/07/visually-weighted-regression.html}
#'
#' \url{http://www.fight-entropy.com/2012/08/visually-weighted-confidence-intervals.html}
#'
#' \url{http://www.fight-entropy.com/2012/08/watercolor-regression.html}
#'
#' \url{https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2265501}

vwReg <- function(formula, data, title = "", B = 1000, shade = TRUE,
                  shade.alpha = .1, spag = FALSE, spag.color = "darkblue",
                  mweight = TRUE, show.lm = FALSE, show.median = TRUE,
                  median.col = "white", shape = 21, show.CI = FALSE,
                  method = loess, bw = FALSE, slices = 200, palette =
                    colorRampPalette(c("#FFEDA0", "#DD0000"), bias = 2)(20),
                  ylim = NULL, quantize = "continuous", add = FALSE, ...) {
  IV <- all.vars(formula)[2]
  DV <- all.vars(formula)[1]
  data <- na.omit(data[order(data[, IV]), c(IV, DV)])

  if (bw == TRUE) {
    palette <- colorRampPalette(c("#EEEEEE", "#999999", "#333333"), bias = 2)(20)
  }

  message("Computing boostrapped smoothers ...")
  newx <- data.frame(seq(min(data[, IV]), max(data[, IV]), length = slices))
  colnames(newx) <- IV
  l0.boot <- matrix(NA, nrow = nrow(newx), ncol = B)

  l0 <- method(formula, data)
  for (i in 1:B) {
    data2 <- data[sample(nrow(data), replace = TRUE), ]
    data2 <- data2[order(data2[, IV]), ]
    if (inherits(l0, "loess")) {
      m1 <- method(formula, data2, control = loess.control(surface = "i", statistics = "a", trace.hat = "a"), ...)
    } else {
      m1 <- method(formula, data2, ...)
    }
    l0.boot[, i] <- predict(m1, newdata = newx)
  }

  # compute median and CI limits of bootstrap
  M <- NULL
  UL <- NULL
  LL <- NULL
  CI.boot <- adply(l0.boot, 1, function(x) quantile(x, prob = c(.025, .5, .975, pnorm(c(-3, -2, -1, 0, 1, 2, 3))), na.rm = TRUE))[, -1]
  colnames(CI.boot)[1:10] <- c("LL", "M", "UL", paste0("SD", 1:7))
  CI.boot$x <- newx[, 1]
  CI.boot$width <- CI.boot$UL - CI.boot$LL

  # scale the CI width to the range 0 to 1 and flip it (bigger numbers = narrower CI)
  w3 <- NULL
  CI.boot$w2 <- (CI.boot$width - min(CI.boot$width))
  CI.boot$w3 <- 1-(CI.boot$w2/max(CI.boot$w2))

  # convert bootstrapped spaghettis to long format
  b2 <- melt(l0.boot)
  b2$x <- newx[,1]
  value <- NULL
  colnames(b2) <- c("index", "B", "value", "x")

  # Construct ggplot
  # All plot elements are constructed as a list, so they can be added to an existing ggplot

  # if add == FALSE: provide the basic ggplot object
  p0 <- ggplot(data, aes(x = !!sym(IV), y = !!sym(DV))) + theme_bw() +
    labs(x = IV, y = DV)

  # initialize elements with NULL (if they are defined, they are overwritten with something meaningful)
  gg.tiles <- gg.poly <- gg.spag <- gg.median <- gg.CI1 <- gg.CI2 <- gg.lm <- gg.points <- gg.title <- NULL

  if (shade == TRUE) {
    quantize <- match.arg(quantize, c("continuous", "SD"))
    if (quantize == "continuous") {
      message("Computing density estimates for each vertical cut ...")
      flush.console()

      if (is.null(ylim)) {
        min_value <- min(min(l0.boot, na.rm = TRUE), min(data[, DV], na.rm = TRUE))
        max_value <- max(max(l0.boot, na.rm = TRUE), max(data[, DV], na.rm = TRUE))
        ylim <- c(min_value, max_value)
      }

      # vertical cross-sectional density estimate
      d2 <- ddply(b2[, c("x", "value")], .(x), function(df) {
        res <- data.frame(density(df$value, na.rm = TRUE, n = slices, from = ylim[1], to = ylim[2])[c("x", "y")])
        colnames(res) <- c("y", "dens")
        return(res)
      }, .progress = "text")

      maxdens <- max(d2$dens)
      mindens <- min(d2$dens)
      dens.scaled <- NULL
      d2$dens.scaled <- (d2$dens - mindens)/maxdens

      ## Tile approach
      alpha.factor <- NULL
      d2$alpha.factor <- d2$dens.scaled^shade.alpha
      x <- NULL
      y <- NULL
      gg.tiles <-  list(geom_tile(data = d2, aes(x = x, y = y, fill = dens.scaled, alpha = alpha.factor)), scale_fill_gradientn("dens.scaled", colours = palette), scale_alpha_continuous(range = c(0.001, 1)))
    }
    if (quantize == "SD") {
      ## Polygon approach

      SDs <- melt(CI.boot[, c("x", paste0("SD", 1:7))], id.vars = "x")
      count <- 0
      d3 <- data.frame()
      col <- c(1,2,3,3,2,1)
      group <- NULL
      for (i in 1:6) {
        seg1 <- SDs[SDs$variable == paste0("SD", i), ]
        seg2 <- SDs[SDs$variable == paste0("SD", i+1), ]
        seg <- rbind(seg1, seg2[nrow(seg2):1, ])
        seg$group <- count
        seg$col <- col[i]
        count <- count + 1
        d3 <- rbind(d3, seg)
      }

      gg.poly <-  list(geom_polygon(data = d3, aes(x = x, y = value, color = NULL, fill = col, group = group)), scale_fill_gradientn("dens.scaled", colours = palette, values = seq(-1, 3, 1)))
    }
  }

  message("Build ggplot figure ...")
  flush.console()

  if (spag == TRUE) {
    gg.spag <-  geom_path(data = b2, aes(x = x, y = value, group = B), linewidth = 0.7, alpha = 10/B, color = spag.color)
  }

  if (show.median == TRUE) {
    if (mweight == TRUE) {
      gg.median <-  geom_path(data = CI.boot, aes(x = x, y = M, alpha = w3^3), linewidth = .6, linejoin = "mitre", color = median.col)
    } else {
      gg.median <-  geom_path(data = CI.boot, aes(x = x, y = M), linewidth = 0.6, linejoin = "mitre", color = median.col)
    }
  }

  # Confidence limits
  if (show.CI == TRUE) {
    gg.CI1 <- geom_path(data = CI.boot, aes(x = x, y = UL), linewidth = 1, color = "red")
    gg.CI2 <- geom_path(data = CI.boot, aes(x = x, y = LL), linewidth = 1, color = "red")
  }

  # plain linear regression line
  if (show.lm == TRUE) {gg.lm <- geom_smooth(method = "lm", color = "darkgreen", se = FALSE)}

  gg.points <- geom_point(data = data, aes(x = !!sym(IV), y = !!sym(DV)), size = 1, shape = shape, fill = "white", color = "black")

  if (title != "") {
    gg.title <- theme(title = title)
  }

  gg.elements <- list(gg.tiles, gg.poly, gg.spag, gg.median, gg.CI1, gg.CI2, gg.lm, gg.points, gg.title, theme(legend.position = "none"))

  if (add == FALSE) {
    return(p0 + gg.elements)
  } else {
    return(gg.elements)
  }
}
