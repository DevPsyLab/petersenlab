library(testthat)

# Define a test for load_or_install function
test_that("load_or_install installs and loads packages correctly", {
  # Set up a temporary library directory
  temp_lib <- tempdir()
  old_libs <- .libPaths() # Save current library paths
  .libPaths(temp_lib)

  # Run load_or_install function
  oldpath <- getwd()
  filelocation <- system.file(
    "extdata",
    "testpackage1_0.1.0.tar.gz",
    package = "petersenlab")
  filepath <- dirname(filelocation)
  newpath <- setwd(filepath)
  setwd(newpath)
  load_or_install(
    c("testpackage1", "testpackage2"),
    repos = NULL,
    type = "source")

  # Check if packages are installed and loaded correctly
  expect_true("testpackage1" %in% installed.packages())
  expect_true(requireNamespace("testpackage1", quietly = TRUE))
  expect_true("testpackage2" %in% installed.packages())
  expect_true(requireNamespace("testpackage2", quietly = TRUE))

  # Clean up
  .libPaths(old_libs)  # Restore original library paths
  setwd(oldpath)
})

# Run the tests
test_load_or_install()
