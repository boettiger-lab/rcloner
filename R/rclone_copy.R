#' Copy files between remotes or local paths
#'
#' Copies files from `src` to `dest`, skipping files that are identical.
#' Does not delete files at the destination.
#'
#' @param src Source path (local or remote).
#' @param dest Destination path (local or remote).
#' @param progress Logical; show transfer progress. Default `FALSE`.
#' @param ... Additional rclone flags as character strings.
#' @return Invisibly, the rclone result list.
#' @export
#' @examples
#' \dontrun{
#' rclone_copy("myremote:bucket/file.csv", "/tmp/file.csv")
#' rclone_copy("/local/dir", "myremote:bucket/dir", progress = TRUE)
#' }
rclone_copy <- function(src, dest, progress = FALSE, ...) {
  args <- c("copy", src, dest)
  if (progress) args <- c(args, "--progress")
  args <- c(args, ...)
  invisible(rclone(args))
}

#' Move files between remotes or local paths
#'
#' Moves files from `src` to `dest`. Source files are deleted after a
#' successful transfer.
#'
#' @inheritParams rclone_copy
#' @return Invisibly, the rclone result list.
#' @export
rclone_move <- function(src, dest, progress = FALSE, ...) {
  args <- c("move", src, dest)
  if (progress) args <- c(args, "--progress")
  args <- c(args, ...)
  invisible(rclone(args))
}

#' Sync a source to a destination
#'
#' Makes `dest` identical to `src`, **deleting** files in `dest` that are not
#' in `src`. Use [rclone_copy()] if you do not want deletions.
#'
#' @inheritParams rclone_copy
#' @return Invisibly, the rclone result list.
#' @export
#' @examples
#' \dontrun{
#' rclone_sync("myremote:bucket", "/local/backup")
#' }
rclone_sync <- function(src, dest, progress = FALSE, ...) {
  args <- c("sync", src, dest)
  if (progress) args <- c(args, "--progress")
  args <- c(args, ...)
  invisible(rclone(args))
}

#' Copy a URL directly to a remote
#'
#' Downloads a URL and uploads it to `dest` without storing it locally first.
#'
#' @param url URL to copy.
#' @param dest Destination remote path.
#' @param ... Additional rclone flags.
#' @return Invisibly, the rclone result list.
#' @export
rclone_copyurl <- function(url, dest, ...) {
  invisible(rclone(c("copyurl", url, dest, ...)))
}
