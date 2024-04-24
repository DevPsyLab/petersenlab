library(testthat)
library(withr)

# Set up a temporary library directory
temp_lib <- tempdir()
old_libs <- .libPaths() # Save current library paths
.libPaths(c(temp_lib, .libPaths()))

# Run load_or_install() function
oldpath <- getwd()
filelocation <- system.file(
  "extdata",
  "testpackage1_0.1.0.tar.gz",
  package = "petersenlab")
filepath <- dirname(filelocation)
newpath <- filepath #setwd(filepath)
setwd(newpath)

load_or_install(
  c("testpackage1", "testpackage2"),
  repos = NULL,
  type = "source")

# Check if packages are installed, loaded, and attached correctly
expect_true(is.element("testpackage1", installed.packages()[, "Package"]))
expect_true("package:testpackage1" %in% search())
expect_true(is.element("testpackage2", installed.packages()[, "Package"]))
expect_true("package:testpackage2" %in% search())

# Clean up
.libPaths(old_libs)  # Restore original library paths
setwd(oldpath)
