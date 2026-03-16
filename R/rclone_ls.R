#' List objects in a remote path
#'
#' Returns a data frame of objects at the given path, parsed from rclone's JSON
#' output. This is the primary listing function and maps to `rclone lsjson`.
#'
#' @param path Remote path in rclone syntax, e.g. `"myremote:bucket/prefix"`.
#'   For local paths use the filesystem path directly.
#' @param recursive Logical; if `TRUE`, list all objects recursively. Default
#'   `FALSE`.
#' @param dirs_only Logical; if `TRUE`, list only directories. Default `FALSE`.
#' @param files_only Logical; if `TRUE`, list only files (no directories).
#'   Default `FALSE`.
#' @param ... Additional flags passed to `rclone lsjson` as strings (e.g.
#'   `"--fast-list"`).
#' @return A data frame with columns `Path`, `Name`, `Size`, `MimeType`,
#'   `ModTime`, `IsDir`, and optionally others returned by rclone.
#' @export
#' @examples
#' \dontrun{
#' rclone_ls("myremote:mybucket")
#' rclone_ls("myremote:mybucket/prefix", recursive = TRUE)
#' }
rclone_ls <- function(path, recursive = FALSE, dirs_only = FALSE,
                       files_only = FALSE, ...) {
  args <- c("lsjson", path)
  if (recursive)  args <- c(args, "--recursive")
  if (dirs_only)  args <- c(args, "--dirs-only")
  if (files_only) args <- c(args, "--files-only")
  args <- c(args, ...)

  result <- rclone(args)
  if (!nzchar(trimws(result$stdout))) return(empty_ls_df())

  df <- jsonlite::fromJSON(result$stdout, simplifyDataFrame = TRUE)
  if (length(df) == 0) return(empty_ls_df())
  df
}

#' @keywords internal
empty_ls_df <- function() {
  data.frame(Path = character(), Name = character(), Size = integer(),
             MimeType = character(), ModTime = character(), IsDir = logical(),
             stringsAsFactors = FALSE)
}

#' List directories in a remote path
#'
#' Convenience wrapper around [rclone_ls()] that returns only directories.
#'
#' @inheritParams rclone_ls
#' @return A data frame (see [rclone_ls()]).
#' @export
rclone_lsd <- function(path, recursive = FALSE, ...) {
  rclone_ls(path, recursive = recursive, dirs_only = TRUE, ...)
}

#' Get metadata for a single object
#'
#' @param path Remote path to a single object.
#' @return A one-row data frame with object metadata, or an error if not found.
#' @export
rclone_stat <- function(path) {
  # lsjson on a file returns info for that file
  result <- rclone(c("lsjson", path))
  df <- jsonlite::fromJSON(result$stdout, simplifyDataFrame = TRUE)
  df
}

#' Get total size of a remote path
#'
#' @param path Remote path.
#' @return A named list with `count` (number of objects) and `bytes` (total
#'   size in bytes).
#' @export
rclone_size <- function(path) {
  result <- rclone(c("size", "--json", path))
  jsonlite::fromJSON(result$stdout)
}
