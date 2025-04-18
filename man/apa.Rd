% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/apa.R
\name{apa}
\alias{apa}
\title{APA Format}
\usage{
apa(value, decimals = 3, leading = TRUE)
}
\arguments{
\item{value}{A set of numeric values, either a single number, vector, or set
of columns.}

\item{decimals}{The number of decimal points desired in the output.}

\item{leading}{Logical value: \code{TRUE} for leading zeroes on decimals
and \code{FALSE} for no leading zeroes on decimals. The default is
\code{TRUE}.}
}
\value{
Value(s) in the format specified, with the number of decimals places
indicated and with or without a leading zero, as indicated.
}
\description{
Format decimals and leading zeroes. Adapted from the MOTE package.
}
\details{
Formats decimals and leading zeroes for creating reports in scientific style,
to be consistent with American Psychological Association (APA) format. This
function creates "pretty" character vectors from numeric variables for
printing as part of a report. The value can take a single number, matrix,
vector, or multiple columns from a data frame, as long as they are numeric.
The values will be coerced into numeric if they are characters or logical
values, but this process may result in an error if values are truly
alphabetical.
}
\examples{
apa(value = 0.54674, decimals = 3, leading = TRUE)

}
\seealso{
\url{https://github.com/doomlab/MOTE}

Other formatting: 
\code{\link{pValue}()},
\code{\link{specify_decimal}()},
\code{\link{suppressLeadingZero}()}
}
\concept{formatting}
