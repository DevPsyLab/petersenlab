% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/timesToMinutes.R
\name{convertToMinutes}
\alias{convertToMinutes}
\title{Convert Time to Minutes.}
\usage{
convertToMinutes(hours, minutes, seconds, HHMMSS, HHMM, MMSS)
}
\arguments{
\item{hours}{Character vector of the number of hours.}

\item{minutes}{Character vector of the number of minutes.}

\item{seconds}{Character vector of the number of seconds.}

\item{HHMMSS}{Times in HH:MM:SS format.}

\item{HHMM}{Character vector of times in HH:MM format.}

\item{MMSS}{Character vector of times in MM:SS format.}
}
\value{
Vector of times in minutes.
}
\description{
Convert times to minutes.
}
\details{
Converts times to minutes. To convert times to hours or seconds, see
\link{convertToHours} or \link{convertToSeconds}.
}
\examples{
# Prepare Data
df <- data.frame(hours = c(0,1), minutes = c(15,27), seconds = c(30,13),
  HHMMSS = c("00:15:30","01:27:13"), HHMM = c("00:15","01:27"))

# Convert to Minutes
convertToMinutes(hours = df$hours, minutes = df$minutes,
  seconds = df$seconds)
convertToMinutes(HHMMSS = df$HHMMSS)
convertToMinutes(HHMM = df$HHMM)
}
\seealso{
Other times: 
\code{\link{convertHoursAMPM}()},
\code{\link{convertToHours}()},
\code{\link{convertToSeconds}()}

Other conversion: 
\code{\link{convert.magic}()},
\code{\link{convertHoursAMPM}()},
\code{\link{convertToHours}()},
\code{\link{convertToSeconds}()},
\code{\link{percentileToTScore}()},
\code{\link{pom}()}
}
\concept{conversion}
\concept{times}
