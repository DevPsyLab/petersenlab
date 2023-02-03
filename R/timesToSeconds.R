#' @title
#' Convert Time to Seconds.
#'
#' @description
#' Convert times to seconds.
#'
#' @details
#' Converts times to seconds. To convert times to hours or minutes, see
#' \link{convertToHours} or \link{convertToMinutes}.
#'
#' @param hours Character vector of the number of hours.
#' @param minutes Character vector of the number of minutes.
#' @param seconds Character vector of the number of seconds.
#' @param HHMMSS Times in HH:MM:SS format.
#' @param HHMM Character vector of times in HH:MM format.
#' @param MMSS Character vector of times in MM:SS format.
#'
#' @return Vector of times in seconds.
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
#'   HHMMSS = c("00:15:30","01:27:13"), HHMM = c("00:15","01:27"),
#'   MMSS = c("15:30","87:13"))
#'
#' # Convert to Minutes
#' convertToSeconds(hours = df$hours, minutes = df$minutes,
#'   seconds = df$seconds)
#' convertToSeconds(HHMMSS = df$HHMMSS)
#' convertToSeconds(HHMM = df$HHMM)
#' convertToSeconds(MMSS = df$MMSS)

convertToSeconds <- function(hours, minutes, seconds, HHMMSS, HHMM, MMSS){
  if(!missing(HHMMSS)){
    X <- strsplit(as.character(HHMMSS), ":")
    secondsTotal <- sapply(X, function(Y) sum(as.numeric(Y) * c(3600, 60, 1)))
  } else if(!missing(HHMM)){
    X <- strsplit(as.character(HHMM), ":")
    secondsTotal <- sapply(X, function(Y) sum(as.numeric(Y) * c(3600, 60)))
  } else if(!missing(MMSS)){
    X <- strsplit(as.character(MMSS), ":")
    secondsTotal <- sapply(X, function(Y) sum(as.numeric(Y) * c(60, 1)))
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
    secondsTotal <- mySum(cbind(as.numeric(hours) * 3600, as.numeric(minutes) * 60, as.numeric(seconds) * 1))
    secondsTotal[idsWithoutData] <- NA
  }
  return(secondsTotal)
}
