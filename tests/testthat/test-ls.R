test_that("rclone_ls() on a local directory returns a data frame", {
  skip_on_cran()
  skip_if_not(nzchar(Sys.which("rclone")), "rclone not on PATH")

  dir <- withr::local_tempdir()
  writeLines("hello", file.path(dir, "test.txt"))

  result <- rclone_ls(dir, files_only = TRUE)
  expect_s3_class(result, "data.frame")
  expect_true("Name" %in% names(result))
  expect_true("test.txt" %in% result$Name)
})

test_that("rclone_ls() returns an empty data frame for an empty directory", {
  skip_on_cran()
  skip_if_not(nzchar(Sys.which("rclone")), "rclone not on PATH")

  dir <- withr::local_tempdir()
  result <- rclone_ls(dir)
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 0L)
})

test_that("rclone_size() returns a list with count and bytes", {
  skip_on_cran()
  skip_if_not(nzchar(Sys.which("rclone")), "rclone not on PATH")

  dir <- withr::local_tempdir()
  writeLines("hello", file.path(dir, "test.txt"))

  result <- rclone_size(dir)
  expect_type(result, "list")
  expect_true("count" %in% names(result) || "bytes" %in% names(result))
})
