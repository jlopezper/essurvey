your_email <- Sys.getenv("your_email")
save_dir <- tempdir()

test_that("Download function return correct errors", {
  
  testthat::skip_on_cran()
  
  # These are the functions which are actually doing the work of testing this, not ess_rounds
  # For wrong emails, test it will through error
  
  expect_error(authenticate("random@email.morerandom"),
               "email address you provided is not associated with any registered")
  
  # Remember that download_format is very sensitive to arguments
  # If both rounds and country are specified, then it downloads
  # country rounds. If only rounds are specified, only
  # rounds are specified. That's why I name every argument.
  # Test round download throw error when round is not available
  expect_error(download_format(rounds = c(1, 22), your_email = your_email),
               "ESS round [0-9]+ is not a available. Check show_rounds()")
  
  # Test country download will throw error when wave is not available
  expect_error(download_format(rounds = c(1, 22), country = "Sweden", your_email = your_email),
               "Only rounds (.*) available for Sweden")
})

test_that("download_format can download COUNTRY files in STATA format successfully", {
  
  testthat::skip_on_cran()
  # Test whether you get a message where the downloads are at
  which_rounds <- 2
  expect_message(download_link <-
                   download_format(
                     rounds = 1:which_rounds,
                     country = "Spain",
                     your_email = your_email,
                     only_download = TRUE,
                     output_dir = tempdir(),
                     format = 'stata'),
                 "All files saved to")
  
  # Test whether the downloaded files are indeed there
  ess_files <- list.files(download_link, pattern = "ESS", recursive = TRUE)
  
  # Same number of stata files as the rounds attempted
  # to download?
  expect_equal(sum(grepl(".dta", ess_files)), which_rounds)
  
  # Same number of zip files as the rounds attempted
  # to download?
  expect_equal(sum(grepl(".zip", ess_files)), which_rounds)
  
  # Same number of do files as the rounds attempted
  # to download?
  expect_equal(sum(grepl(".do", ess_files)), which_rounds)
  
  # Delete all downloaded files
  unlink(save_dir, recursive = TRUE, force = TRUE)
})

test_that("download_format can download ROUND files in STATA format successfully", {
  
  testthat::skip_on_cran()
  # Test whether you get a message where the downloads are at
  which_rounds <- 2
  expect_message(download_link <-
                   download_format(
                     rounds = 1:which_rounds,
                     your_email = your_email,
                     only_download = TRUE,
                     output_dir = tempdir(),
                     format = 'stata'),
                 "All files saved to")
  
  # Test whether the downloaded files are indeed there
  ess_files <- list.files(download_link, pattern = "ESS", recursive = TRUE)
  
  # Same number of stata files as the rounds attempted
  # to download?
  expect_equal(sum(grepl(".dta", ess_files)), which_rounds)
  
  # Same number of zip files as the rounds attempted
  # to download?
  expect_equal(sum(grepl(".zip", ess_files)), which_rounds)
  
  # Same number of do files as the rounds attempted
  # to download?
  expect_equal(sum(grepl(".do", ess_files)), which_rounds)
  
  # Delete all downloaded files
  unlink(download_link, recursive = TRUE, force = TRUE)
})

test_that("download_format can download COUNTRY files in SPSS format successfully", {
  
  testthat::skip_on_cran()
  # Test whether you get a message where the downloads are at
  which_rounds <- 2
  expect_message(download_link <-
                   download_format(
                     rounds = 1:which_rounds,
                     country = "Spain",
                     your_email = your_email,
                     only_download = TRUE,
                     output_dir = tempdir(),
                     format = 'spss'),
                 "All files saved to")
  
  # Test whether the downloaded files are indeed there
  ess_files <- list.files(download_link, pattern = "ESS", recursive = TRUE)
  
  # Same number of stata files as the rounds attempted
  # to download?
  expect_equal(sum(grepl(".sav", ess_files)), which_rounds)
  
  # Same number of zip files as the rounds attempted
  # to download?
  expect_equal(sum(grepl(".zip", ess_files)), which_rounds)
  
  # Same number of do files as the rounds attempted
  # to download?
  expect_equal(sum(grepl(".por", ess_files)), which_rounds)
  
  # Delete all downloaded files
  unlink(save_dir, recursive = TRUE, force = TRUE)
})

test_that("download_format can download ROUND files in SPSS format successfully", {
  
  testthat::skip_on_cran()
  # Test whether you get a message where the downloads are at
  which_rounds <- 2
  expect_message(download_link <-
                   download_format(
                     rounds = 1:which_rounds,
                     your_email = your_email,
                     only_download = TRUE,
                     output_dir = tempdir(),
                     format = 'spss'),
                 "All files saved to")
  
  # Test whether the downloaded files are indeed there
  ess_files <- list.files(download_link, pattern = "ESS", recursive = TRUE)
  
  # Same number of stata files as the rounds attempted
  # to download?
  expect_equal(sum(grepl(".sav", ess_files)), which_rounds)
  
  # Same number of zip files as the rounds attempted
  # to download?
  expect_equal(sum(grepl(".zip", ess_files)), which_rounds)
  
  # Same number of do files as the rounds attempted
  # to download?
  expect_equal(sum(grepl(".por", ess_files)), which_rounds)
  
  # Delete all downloaded files
  unlink(save_dir, recursive = TRUE, force = TRUE)
})

test_that("download_format can download COUNTRY files in SAS format successfully", {
  
  testthat::skip_on_cran()
  # Test whether you get a message where the downloads are at
  which_rounds <- 2
  expect_message(download_link <-
                   download_format(
                     rounds = 1:which_rounds,
                     country = "Spain",
                     your_email = your_email,
                     only_download = TRUE,
                     output_dir = tempdir(),
                     format = 'sas'),
                 "All files saved to")
  
  # Test whether the downloaded files are indeed there
  ess_files <- list.files(download_link, pattern = "ESS", recursive = TRUE)
  
  # SAS needs more files that the number of rounds.
  # It's actually 4 .sas files, 1 .zip file and 
  # 1 .por file per round, so everything multipled by 2.
  expect_equal(sum(grepl(".sas$", ess_files)), 4 * which_rounds)
  
  expect_equal(sum(grepl(".zip$", ess_files)), 1 * which_rounds)
  
  expect_equal(sum(grepl(".por$", ess_files)), 1 * which_rounds)
  
  # Delete all downloaded files
  unlink(save_dir, recursive = TRUE, force = TRUE)
})

test_that("download_format can download ROUND files in SAS format successfully", {
  
  testthat::skip_on_cran()
  # Test whether you get a message where the downloads are at
  which_rounds <- 2
  expect_message(download_link <-
                   download_format(
                     rounds = 1:which_rounds,
                     your_email = your_email,
                     only_download = TRUE,
                     output_dir = tempdir(),
                     format = 'sas'),
                 "All files saved to")
  
  # Test whether the downloaded files are indeed there
  ess_files <- list.files(download_link, pattern = "ESS", recursive = TRUE)
  
  # SAS needs more files that the number of rounds.
  # It's actually 4 .sas files, 1 .zip file and 
  # 1 .por file per round, so everything multipled by 2.
  expect_equal(sum(grepl(".sas$", ess_files)), 4 * which_rounds)
  
  expect_equal(sum(grepl(".zip$", ess_files)), 1 * which_rounds)
  
  expect_equal(sum(grepl(".por$", ess_files)), 1 * which_rounds)
  
  # Delete all downloaded files
  unlink(save_dir, recursive = TRUE, force = TRUE)
})