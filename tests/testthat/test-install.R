test_that("rclone_binary() returns a non-empty path", {
  bin <- rcloner:::rclone_binary()
  expect_true(nzchar(bin))
})

test_that("rclone_os() returns a supported OS string", {
  os <- rcloner:::rclone_os()
  expect_true(os %in% c("linux", "osx", "windows"))
})

test_that("rclone_arch() returns a supported architecture string", {
  arch <- rcloner:::rclone_arch()
  expect_true(arch %in% c("amd64", "arm64", "arm-v7", "386"))
})

test_that("rclone_version() works when rclone is available", {
  skip_if_not(nzchar(Sys.which("rclone")), "rclone not on PATH")
  out <- rclone_version()
  expect_true(grepl("rclone", out, ignore.case = TRUE))
})

test_that("install_rclone() skips gracefully when already installed", {
  skip_on_cran()
  skip_if_not(nzchar(Sys.which("rclone")), "rclone not on PATH")
  # Should not error; should report already installed
  expect_no_error(install_rclone(force = FALSE))
})
