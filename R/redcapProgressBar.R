#' @title
#' Progress Bar for REDCap.
#'
#' @description
#' Function that identifies the values for a progress bar in REDCap.
#'
#' @details
#' A progress bar in REDCap can be created using the following code:
#' \preformatted{
#'   Progress:
#'   <div style="width:100\%;border:0;margin:0;padding:0;background-color:
#'   #A9BAD1;text-align:center;"><div style="width:2\%;border: 0;margin:0;
#'   padding:0;background-color:#8491A2"><span style="color:#8491A2">.
#'   </span></div></div>
#' }
#' where \code{width:2\%} specifies the progress (out of 100\%).
#'
#' @param numSurveys the number of surveys to establish progress.
#' @param beginning the first value to use in the sequence.
#' @param end the last value to use in the sequence.
#'
#' @return sequence of numbers for the progress bar in REDCap.
#'
#' @export
#'
#' @examples
#' redcapProgressBar(numSurveys = 6)
#' redcapProgressBar(6)
#' redcapProgressBar(4)
#' redcapProgressBar(numSurveys = 7, beginning = 1, end = 99)

redcapProgressBar <- function(numSurveys, beginning = 2, end = 99){
  progressSequence <- seq(
    from = beginning,
    to = end,
    length.out = numSurveys)

  return(progressSequence)
}




