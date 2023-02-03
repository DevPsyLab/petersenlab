#' @title
#' Cross-Time Correlations Dataframe.
#'
#' @description
#' Dataframe used to compute cross-time correlations.
#'
#' @details
#' Dataframe used to calculate the association of a variable across multiple
#' time points. It is especially useful when there are three or more time points.
#'
#' @inheritParams crossTimeCorrelation
#'
#' @return dataframe with three columns in the form of: \code{ID}, \code{time1},
#' \code{time2}
#'
#' @family correlations
#'
#' @importFrom stats na.omit rnorm
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' df <- expand.grid(ID = 1:100, time = c(1, 2, 3))
#' df <- df[order(df$ID),]
#' row.names(df) <- NULL
#' df$score <- rnorm(nrow(df))
#'
#' # Cross-Time Correlation
#' crossTimeCorrelationDF(id = "ID", time = "time", variable = "score", data = df)

crossTimeCorrelationDF <- function(id = "tcid", time = "age", variable, data){
  dataSubset <- data.frame(data[,c(id, time, variable)])

  dataSubset <- dataSubset[order(dataSubset[,id], dataSubset[,time]),]

  duplicatedIDs <- unique(dataSubset[,id][duplicated(dataSubset[,id]) == TRUE])

  fullMatrix <- matrix(nrow = 0, ncol = 3)

  for(i in 1:length(duplicatedIDs)){
    uniqueScores <- dataSubset[dataSubset[,id] == duplicatedIDs[i], variable]
    newMatrix <- matrix(nrow = length(uniqueScores) - 1, ncol = 3)
    for(j in 1:(length(uniqueScores) - 1)){
      newMatrix[j, 1] <- duplicatedIDs[i]
      newMatrix[j, 2] <- uniqueScores[j]
      newMatrix[j, 3] <- uniqueScores[j + 1]
    }
    fullMatrix <- rbind(fullMatrix, newMatrix)
  }
  colnames(fullMatrix) <- c(id, "time1", "time2")
  fullMatrix <- as.data.frame(na.omit(fullMatrix))
  fullMatrix$time1 <- as.numeric(fullMatrix$time1)
  fullMatrix$time2 <- as.numeric(fullMatrix$time2)

  return(fullMatrix)
}
