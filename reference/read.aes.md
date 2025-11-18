# Read Encrypted Data.

Read data from encrypted file.

## Usage

``` r
read.aes(filename, key)
```

## Arguments

- filename:

  Location of encrypted data.

- key:

  Encryption key.

## Value

Unencrypted data.

## Details

Reads data from an encrypted file. To write an data to an encrypted
file, see
[write.aes](https://devpsylab.github.io/petersenlab/reference/write.aes.md).

## See also

<https://stackoverflow.com/questions/25318800/how-do-i-read-an-encrypted-file-from-disk-with-r/25321586#25321586>

Other encrypted:
[`write.aes()`](https://devpsylab.github.io/petersenlab/reference/write.aes.md)

## Examples

``` r
# \donttest{
# Location of Encryption Key on Local Computer (where only you should have access to it)
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
#  key = key) # Change the file location to save this on the lab drive

write.aes(
  df = credentials,
  filename = encryptedCredentialsLocation,
  key = key)

rm(credentials)
rm(key)

# Read and Unencrypt the Credentials Using the Encryption Key
load(encryptionKeyLocation)

#credentials <- read.aes(
#  filename = file.path(getwd(), "/encrypytedCredentials.txt", fsep = ""),
#  key = key)

credentials <- read.aes(
  filename = encryptedCredentialsLocation,
  key = key)
# }
```
