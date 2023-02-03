#' @title
#' Write Encrypted Data.
#'
#' @description
#' Write data to encrypted file.
#'
#' @details
#' Writes data to an encrypted file. To read data from an encrypted file, see
#' \link{read.aes}.
#'
#' @param df Data to encrypt.
#' @param filename Location where to save encrypted data.
#' @param key Encryption key.
#'
#' @return
#' A file with encrypted data.
#'
#' @family encrypted
#'
#' @export
#'
#' @importFrom digest AES
#'
#' @examples
#' # Location Where to Save Encryption Key on Local Computer
#'   #(where only you should have access to it)
#' encryptionKeyLocation <- file.path(getwd(), "/encryptionKey.RData",
#'   fsep = "") #Can change to a different path, e.g.: "C:/Users/[USERNAME]/"
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
#' # Save Encrypted Credentials
#' write.aes(df = credentials,
#'   filename = file.path(getwd(), "/encrypytedCredentials.txt", fsep = ""),
#'   key = key) #Change the file location to save this on the lab drive
#' rm(credentials)
#' rm(key)
#'
#' @seealso
#' \url{https://stackoverflow.com/questions/25318800/how-do-i-read-an-encrypted-file-from-disk-with-r/25321586#25321586}

write.aes <- function(df, filename, key) {
  zz <- textConnection("out", "w")
  write.csv(df, zz, row.names = FALSE)
  close(zz)
  out <- paste(out, collapse = "\n")
  raw <- charToRaw(out)
  raw <- c(raw, as.raw(rep(0, 16 - length(raw) %% 16)))
  aes <- AES(key, mode = "ECB")
  aes$encrypt(raw)
  writeBin(aes$encrypt(raw), filename)
}
