#' Configure an rclone remote
#'
#' Creates or updates a named remote in the rclone config file. This is the
#' primary way to register cloud storage credentials with rclone.
#'
#' @param name Name for the remote (used as the prefix in paths, e.g.
#'   `"myremote:bucket/key"`).
#' @param type Remote type, e.g. `"s3"`, `"gcs"`, `"azureblob"`, `"drive"`.
#'   Run `rclone("help backends")` to see all supported types.
#' @param ... Named parameters passed to the remote configuration. For S3
#'   remotes this typically includes `provider`, `access_key_id`,
#'   `secret_access_key`, and optionally `endpoint` (for non-AWS S3).
#' @return Invisibly, the result of the rclone command.
#' @export
#' @examples
#' \dontrun{
#' # AWS S3
#' rclone_config_create("aws", type = "s3",
#'   provider = "AWS",
#'   access_key_id = Sys.getenv("AWS_ACCESS_KEY_ID"),
#'   secret_access_key = Sys.getenv("AWS_SECRET_ACCESS_KEY"),
#'   region = "us-east-1"
#' )
#'
#' # MinIO / S3-compatible
#' rclone_config_create("minio", type = "s3",
#'   provider = "Minio",
#'   access_key_id = Sys.getenv("MINIO_ACCESS_KEY"),
#'   secret_access_key = Sys.getenv("MINIO_SECRET_KEY"),
#'   endpoint = "https://minio.example.com"
#' )
#' }
rclone_config_create <- function(name, type, ...) {
  params <- list(...)
  args <- c("config", "create", name, type)
  for (key in names(params)) {
    args <- c(args, key, as.character(params[[key]]))
  }
  invisible(rclone(args))
}

#' Set individual parameters on an existing remote
#'
#' @param name Remote name.
#' @param ... Named parameters to set (key = value).
#' @return Invisibly, the result of the rclone command.
#' @export
#' @examples
#' \dontrun{
#' rclone_config_set("myremote", region = "us-west-2")
#' }
rclone_config_set <- function(name, ...) {
  params <- list(...)
  args <- c("config", "update", name)
  for (key in names(params)) {
    args <- c(args, key, as.character(params[[key]]))
  }
  invisible(rclone(args))
}

#' Show rclone configuration
#'
#' @param name Optional remote name. If omitted, shows all remotes.
#' @return Character string with the configuration (invisibly). Also prints
#'   to the console.
#' @export
#' @examples
#' \examplesIf{rclone_available()}
#' rclone_config_show()
rclone_config_show <- function(name = NULL) {
  args <- c("config", "show")
  if (!is.null(name)) args <- c(args, name)
  result <- rclone(args)
  cat(result$stdout)
  invisible(result$stdout)
}

#' Delete an rclone remote
#'
#' @param name Remote name to delete.
#' @return Invisibly, the result of the rclone command.
#' @export
#' @examples
#' \dontrun{
#' rclone_config_delete("myremote")
#' }
rclone_config_delete <- function(name) {
  invisible(rclone(c("config", "delete", name)))
}

#' List configured remotes
#'
#' @return Character vector of remote names.
#' @export
#' @examples
#' \examplesIf{rclone_available()}
#' rclone_listremotes()
rclone_listremotes <- function() {
  result <- rclone("listremotes")
  remotes <- strsplit(trimws(result$stdout), "\n")[[1]]
  remotes <- sub(":$", "", remotes)
  remotes[nzchar(remotes)]
}
