#' @title
#' Convert Time to Hours.
#'
#' @description
#' Convert times to hours.
#'
#' @details
#' Converts times to hours. To convert times to minutes or seconds, see
#' \link{convertToMinutes} or \link{convertToSeconds}.
#'
#' @inheritParams convertToSeconds
#'
#' @return Vector of times in hours.
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
#' # Convert to Hours
#' convertToHours(hours = df$hours, minutes = df$minutes, seconds = df$seconds)
#' convertToHours(HHMMSS = df$HHMMSS)
#' convertToHours(HHMM = df$HHMM)

convertToHours <- function(hours, minutes, seconds, HHMMSS, HHMM){
  if(!missing(HHMMSS)){
    X <- strsplit(as.character(HHMMSS), ":")
    hoursTotal <- sapply(X, function(Y) sum(as.numeric(Y) * c(1, (1/60), (1/3600)), na.rm = TRUE))
  } else if(!missing(HHMM)){
    X <- strsplit(as.character(HHMM), ":")
    hoursTotal <- sapply(X, function(Y) sum(as.numeric(Y) * c(1, (1/60)), na.rm = TRUE))
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
    hoursTotal <- mySum(cbind(as.numeric(hours) * 1, as.numeric(minutes) * (1/60), as.numeric(seconds) * (1/3600)))
    hoursTotal[idsWithoutData] <- NA
  }
  return(hoursTotal)
}
