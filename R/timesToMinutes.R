#' @title
#' Convert Time to Minutes.
#'
#' @description
#' Convert times to minutes.
#'
#' @details
#' Converts times to minutes. To convert times to hours or seconds, see
#' \link{convertToHours} or \link{convertToSeconds}.
#'
#' @inheritParams convertToSeconds
#'
#' @return Vector of times in minutes.
#'
#' @family times
#' @family conversion
#'
#' @importFrom stats na.omit
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' df <- data.frame(hours = c(0,1), minutes = c(15,27), seconds = c(30,13),
#'   HHMMSS = c("00:15:30","01:27:13"), HHMM = c("00:15","01:27"))
#'
#' # Convert to Minutes
#' convertToMinutes(hours = df$hours, minutes = df$minutes,
#'   seconds = df$seconds)
#' convertToMinutes(HHMMSS = df$HHMMSS)
#' convertToMinutes(HHMM = df$HHMM)

convertToMinutes <- function(hours, minutes, seconds, HHMMSS, HHMM, MMSS){
  if(!missing(HHMMSS)){
    X <- strsplit(as.character(HHMMSS), ":")
    minutesTotal <- sapply(X, function(Y) sum(as.numeric(Y) * c(60, 1, (1/60)), na.rm = TRUE))
  } else if(!missing(HHMM)){
    X <- strsplit(as.character(HHMM), ":")
    minutesTotal <- sapply(X, function(Y) sum(as.numeric(Y) * c(60, 1), na.rm = TRUE))
  } else if(!missing(MMSS)){
    X <- strsplit(as.character(MMSS), ":")
    minutesTotal <- sapply(X, function(Y) sum(as.numeric(Y) * c(60, (1/60)), na.rm = TRUE))
  } else{
    idsWithHours <- NA
    idsWithMinutes <- NA
    idsWithSeconds <- NA
    lengthHours <- NA
    lengthMinutes <- NA
    lengthSeconds <- NA
    if(!missing(hours)){
      idsWithHours <- which(!is.na(hours))
      lengthHours <- length(hours)
    }
    if(!missing(minutes)){
      idsWithMinutes <- which(!is.na(minutes))
      lengthMinutes <- length(minutes)
    }
    if(!missing(seconds)){
      idsWithSeconds <- which(!is.na(seconds))
      lengthSeconds <- length(seconds)
    }
    maxLength <- 1:max(c(lengthHours, lengthMinutes, lengthSeconds), na.rm = TRUE)
    idsWithData <- unique(na.omit(c(idsWithHours, idsWithMinutes, idsWithSeconds)))
    idsWithoutData <- maxLength[maxLength %ni% idsWithData]
    if(missing(hours) & missing(minutes) & missing(seconds)){
      hours <- NA
      minutes <- NA
      seconds <- NA
    } else{
      if(missing(hours)){
        hours <- 0
      }
      if(missing(minutes)){
        minutes <- 0
      }
      if(missing(seconds)){
        seconds <- 0
      }
    }
    minutesTotal <- mySum(cbind(as.numeric(hours) * 60, as.numeric(minutes) * 1, as.numeric(seconds) * (1/60)))
    minutesTotal[idsWithoutData] <- NA
  }
  return(minutesTotal)
}
