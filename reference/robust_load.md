# Robustly Load R Objects from a URL with Retry Logic

Attempts to load an R object from a URL using \`load()\`, with automatic
retries on failure. By default, it will retry indefinitely until
successful.

## Usage

``` r
robust_load(url, max_attempts = NULL, delay = 2, envir = .GlobalEnv, ...)
```

## Arguments

- url:

  A character string specifying the URL from which to load the
  \`.RData\` object.

- max_attempts:

  The maximum number of attempts before giving up. If \`NULL\` (the
  default), the function will retry indefinitely until successful.

- delay:

  The number of seconds to wait between attempts (default = 2).

- envir:

  The environment into which the data should be loaded (default is the
  global environment).

- ...:

  Parameters to pass to the \`load()\` function

## Value

Invisibly returns \`TRUE\` if loading succeeds. On failure after
reaching the maximum number of attempts, an error is thrown.

## Details

This function wraps a call to \`load(url(...))\` in a retry loop. It is
useful when loading data from unstable remote sources (e.g., OSF,
Dropbox, GitHub) where temporary network errors may occur. Users may
optionally set a maximum number of retry attempts and a delay between
retries. The function also closes the connection after each attempt to
prevent resource leaks.

## Examples

``` r
# Example of a successful load (will do nothing if URL is valid)
# \donttest{
robust_load("https://osf.io/download/yx5h6/")

# Example with limited retries
robust_load("https://osf.io/download/yx5h6/", max_attempts = 4, delay = 1)

# Example of a failing load, wrapped safely to pass R CMD check
try(
  robust_load("https://osf.io/download/THISISATEST/", max_attempts = 3, delay = 1),
  silent = TRUE
)
#> Warning: cannot open URL 'https://osf.io/download/THISISATEST/': HTTP status was '404 Not Found'
#> Attempt 1 failed: cannot open the connection to 'https://osf.io/download/THISISATEST/'
#> Warning: cannot open URL 'https://osf.io/download/THISISATEST/': HTTP status was '404 Not Found'
#> Attempt 2 failed: cannot open the connection to 'https://osf.io/download/THISISATEST/'
#> Warning: cannot open URL 'https://osf.io/download/THISISATEST/': HTTP status was '404 Not Found'
#> Attempt 3 failed: cannot open the connection to 'https://osf.io/download/THISISATEST/'
# }
```
