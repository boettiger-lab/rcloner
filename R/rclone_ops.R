#' Output file content to R
#'
#' Reads the content of a remote file and returns it as a character string,
#' analogous to `cat` on the command line.
#'
#' @param path Remote path to the file.
#' @return Character string with the file content.
#' @export
#' @examplesIf rclone_available()
#' tmp <- tempfile(fileext = ".txt")
#' writeLines("hello rclone", tmp)
#' txt <- rclone_cat(tmp)
#' cat(txt)
#' \dontrun{
#' txt <- rclone_cat("myremote:bucket/readme.txt")
#' cat(txt)
#' }
rclone_cat <- function(path) {
  result <- rclone(c("cat", path))
  result$stdout
}

#' Delete files at a remote path
#'
#' Deletes the files (not directories) at the given path. To remove a directory
#' and all its contents use [rclone_purge()].
#'
#' @param path Remote path to delete.
#' @param ... Additional rclone flags.
#' @return Invisibly, the rclone result list.
#' @export
#' @examplesIf rclone_available()
#' d <- tempfile()
#' dir.create(d)
#' writeLines("hi", file.path(d, "f.txt"))
#' rclone_delete(d)
rclone_delete <- function(path, ...) {
  invisible(rclone(c("delete", path, ...)))
}

#' Remove an empty directory
#'
#' @param path Remote path to the directory.
#' @return Invisibly, the rclone result list.
#' @export
#' @examplesIf rclone_available()
#' d <- tempfile()
#' dir.create(d)
#' rclone_rmdir(d)
rclone_rmdir <- function(path) {
  invisible(rclone(c("rmdir", path)))
}

#' Remove a path and all its contents
#'
#' Deletes all files and directories under `path`. Use with caution.
#'
#' @param path Remote path to purge.
#' @return Invisibly, the rclone result list.
#' @export
#' @examplesIf rclone_available()
#' d <- tempfile()
#' dir.create(d)
#' writeLines("hi", file.path(d, "f.txt"))
#' rclone_purge(d)
rclone_purge <- function(path) {
  invisible(rclone(c("purge", path)))
}

#' Create a directory or bucket
#'
#' @param path Remote path to create.
#' @return Invisibly, the rclone result list.
#' @export
#' @examplesIf rclone_available()
#' d <- tempfile()
#' rclone_mkdir(d)
rclone_mkdir <- function(path) {
  invisible(rclone(c("mkdir", path)))
}

#' Check whether two remotes are in sync
#'
#' Compares the files in `src` and `dest` without transferring anything.
#' Differences are reported as messages.
#'
#' @param src Source path.
#' @param dest Destination path.
#' @param ... Additional rclone flags.
#' @return Invisibly, the rclone result list (check stderr for differences).
#' @export
#' @examplesIf rclone_available()
#' src <- tempfile()
#' dir.create(src)
#' dest <- tempfile()
#' dir.create(dest)
#' rclone_check(src, dest)
rclone_check <- function(src, dest, ...) {
  invisible(rclone(c("check", src, dest, ...), error_on_status = FALSE))
}

#' Show rclone version information
#'
#' @return Invisibly, a character string with the version output.
#' @export
#' @examplesIf rclone_available()
#' rclone_version()
rclone_version <- function() {
  result <- rclone("version")
  cat(result$stdout)
  invisible(result$stdout)
}

#' Generate a public link for a remote file
#'
#' Not all remotes support this operation.
#'
#' @param path Remote path to the file.
#' @return Character string with the public URL.
#' @export
#' @examples
#' \dontrun{
#' rclone_link("myremote:bucket/file.csv")
#' }
rclone_link <- function(path) {
  result <- rclone(c("link", path))
  trimws(result$stdout)
}

#' Get quota information for a remote
#'
#' @param path Remote name or path (e.g. `"myremote:"`).
#' @return A list with quota details (free, used, total bytes).
#' @export
#' @examples
#' \dontrun{
#' rclone_about("myremote:")
#' }
rclone_about <- function(path) {
  result <- rclone(c("about", "--json", path))
  jsonlite::fromJSON(result$stdout)
}
