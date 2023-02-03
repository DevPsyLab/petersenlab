#' @title
#' Set Lab Path.
#'
#' @description
#' Sets the path directory to the lab drive.
#'
#' @details
#' Sets the path directory to the lab drive, and saves it in the object
#' \code{petersenLab}.
#'
#' @return
#' The object \code{petersenLab} with containing the path directory to the lab
#' drive.
#'
#' @family lab
#'
#' @export
#'
#' @examples
#' petersenLabPath <- setLabPath()

setLabPath <- function(){
  if(dir.exists("//iowa.uiowa.edu/shared/ResearchData/rdss_itpetersen/Lab")){
    petersenLab <- "//iowa.uiowa.edu/shared/ResearchData/rdss_itpetersen"
  } else if(dir.exists("//rdss.iowa.uiowa.edu/rdss_itpetersen/Lab")){
    petersenLab <- "//rdss.iowa.uiowa.edu/rdss_itpetersen"
  } else {
    petersenLab <- "/Volumes/rdss_itpetersen"
  }
}
