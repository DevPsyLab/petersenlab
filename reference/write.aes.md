# Write Encrypted Data.

Write data to encrypted file.

## Usage

``` r
write.aes(df, filename, key)
```

## Arguments

- df:

  Data to encrypt.

- filename:

  Location where to save encrypted data.

- key:

  Encryption key.

## Value

A file with encrypted data.

## Details

Writes data to an encrypted file. To read data from an encrypted file,
see
[read.aes](https://devpsylab.github.io/petersenlab/reference/read.aes.md).

## See also

<https://stackoverflow.com/questions/25318800/how-do-i-read-an-encrypted-file-from-disk-with-r/25321586#25321586>

Other encrypted:
[`read.aes()`](https://devpsylab.github.io/petersenlab/reference/read.aes.md)

## Examples

``` r
# \donttest{
# Location Where to Save Encryption Key on Local Computer
  #(where only you should have access to it)
#encryptionKeyLocation <- file.path(getwd(), "/encryptionKey.RData",
#  fsep = "") #Can change to a different path, e.g.: "C:/Users/[USERNAME]/"

# Generate a Temporary File Path for Encryption Key
encryptionKeyLocation <- tempfile(fileext = ".RData")

# Generate Encryption Key
key <- as.raw(sample(1:16, 16))

# Save Encryption Key
save(key, file = encryptionKeyLocation)

# Specify Credentials
credentials <- "Insert My Credentials Here"

# Generate a Temporary File Path for Encrypted Credentials
encryptedCredentialsLocation <- tempfile(fileext = ".txt")

# Save Encrypted Credentials
#write.aes(
#  df = credentials,
#  filename = file.path(getwd(), "/encrypytedCredentials.txt", fsep = ""),
#  key = key) #Change the file location to save this on the lab drive

write.aes(
  df = credentials,
  filename = encryptedCredentialsLocation,
  key = key)

rm(credentials)
rm(key)
# }
```
