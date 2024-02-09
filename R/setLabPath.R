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
  if(dir.exists("//lc-rs-store24.hpc.uiowa.edu/lss_itpetersen/Lab")){
    petersenLab <- "//lc-rs-store24.hpc.uiowa.edu/lss_itpetersen"
  } else if(dir.exists("/Volumes/lss_itpetersen/Lab")){
    petersenLab <- "/Volumes/lss_itpetersen"
  } else if(dir.exists("smb://lc-rs-store24.hpc.uiowa.edu/lss_itpetersen/Lab")){
    petersenLab <- "smb://lc-rs-store24.hpc.uiowa.edu/lss_itpetersen"
  } else {
    petersenLab <- "/Shared/lss_itpetersen"
  }
}
