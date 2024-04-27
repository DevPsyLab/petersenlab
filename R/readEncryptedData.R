#' @title
#' Read Encrypted Data.
#'
#' @description
#' Read data from encrypted file.
#'
#' @details
#' Reads data from an encrypted file. To write an data to an encrypted file, see
#' \link{write.aes}.
#'
#' @param filename Location of encrypted data.
#' @param key Encryption key.
#'
#' @return
#' Unencrypted data.
#'
#' @family encrypted
#'
#' @export
#'
#' @importFrom digest AES
#' @importFrom utils read.csv write.csv
#'
#' @examples
#' \donttest{
#' # Location of Encryption Key on Local Computer (where only you should have access to it)
#' #encryptionKeyLocation <- file.path(getwd(), "/encryptionKey.RData",
#' #  fsep = "") #Can change to a different path, e.g.: "C:/Users/[USERNAME]/"
#'
#' # Generate a Temporary File Path for Encryption Key
#' encryptionKeyLocation <- tempfile(fileext = ".RData")
#'
#' # Generate Encryption Key
#' key <- as.raw(sample(1:16, 16))
#'
#' # Save Encryption Key
#' save(key, file = encryptionKeyLocation)
#'
#' # Specify Credentials
#' credentials <- "Insert My Credentials Here"
#'
#' # Generate a Temporary File Path for Encrypted Credentials
#' encryptedCredentialsLocation <- tempfile(fileext = ".txt")
#'
#' # Save Encrypted Credentials
#' #write.aes(
#' #  df = credentials,
#' #  filename = file.path(getwd(), "/encrypytedCredentials.txt", fsep = ""),
#' #  key = key) # Change the file location to save this on the lab drive
#'
#' write.aes(
#'   df = credentials,
#'   filename = encryptedCredentialsLocation,
#'   key = key)
#'
#' rm(credentials)
#' rm(key)
#'
#' # Read and Unencrypt the Credentials Using the Encryption Key
#' load(encryptionKeyLocation)
#'
#' #credentials <- read.aes(
#' #  filename = file.path(getwd(), "/encrypytedCredentials.txt", fsep = ""),
#' #  key = key)
#'
#' credentials <- read.aes(
#'   filename = encryptedCredentialsLocation,
#'   key = key)
#' }
#'
#' @seealso
#' \url{https://stackoverflow.com/questions/25318800/how-do-i-read-an-encrypted-file-from-disk-with-r/25321586#25321586}

read.aes <- function(filename, key) {
  dat <- readBin(filename, "raw", n = 1000)
  aes <- AES(key, mode = "ECB")
  raw <- aes$decrypt(dat, raw = TRUE)
  txt <- rawToChar(raw[raw > 0])
  read.csv(text = txt, stringsAsFactors = FALSE)
}
