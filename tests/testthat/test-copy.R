test_that("rclone_copy() transfers a local file", {
  skip_on_cran()
  skip_if_not(nzchar(Sys.which("rclone")), "rclone not on PATH")

  src  <- withr::local_tempdir()
  dest <- withr::local_tempdir()
  writeLines("hello rcloner", file.path(src, "hello.txt"))

  rclone_copy(src, dest)

  expect_true(file.exists(file.path(dest, "hello.txt")))
  expect_equal(readLines(file.path(dest, "hello.txt")), "hello rcloner")
})

test_that("rclone_sync() mirrors source to destination", {
  skip_on_cran()
  skip_if_not(nzchar(Sys.which("rclone")), "rclone not on PATH")

  src  <- withr::local_tempdir()
  dest <- withr::local_tempdir()
  writeLines("sync me", file.path(src, "a.txt"))

  rclone_sync(src, dest)
  expect_true(file.exists(file.path(dest, "a.txt")))

  # After removing the file from src, sync should remove it from dest too
  file.remove(file.path(src, "a.txt"))
  rclone_sync(src, dest)
  expect_false(file.exists(file.path(dest, "a.txt")))
})

test_that("rclone_move() transfers and removes source file", {
  skip_on_cran()
  skip_if_not(nzchar(Sys.which("rclone")), "rclone not on PATH")

  src  <- withr::local_tempdir()
  dest <- withr::local_tempdir()
  writeLines("move me", file.path(src, "b.txt"))

  rclone_move(src, dest)
  expect_true(file.exists(file.path(dest, "b.txt")))
  expect_false(file.exists(file.path(src, "b.txt")))
})

test_that("rclone_cat() reads a local file", {
  skip_on_cran()
  skip_if_not(nzchar(Sys.which("rclone")), "rclone not on PATH")

  dir <- withr::local_tempdir()
  writeLines("hello world", file.path(dir, "c.txt"))

  out <- rclone_cat(file.path(dir, "c.txt"))
  expect_true(grepl("hello world", out))
})

test_that("rclone_mkdir() and rclone_rmdir() work on local paths", {
  skip_on_cran()
  skip_if_not(nzchar(Sys.which("rclone")), "rclone not on PATH")

  dir <- withr::local_tempdir()
  subdir <- file.path(dir, "newsubdir")

  rclone_mkdir(subdir)
  expect_true(dir.exists(subdir))

  rclone_rmdir(subdir)
  expect_false(dir.exists(subdir))
})
