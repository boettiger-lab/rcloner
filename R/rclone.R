#' Run an rclone command
#'
#' Low-level wrapper that runs any rclone command. Higher-level functions like
#' [rclone_copy()], [rclone_ls()], etc. call this internally.
#'
#' @param args Character vector of arguments passed to rclone (the command and
#'   its flags). Alternatively a single space-delimited string.
#' @param env Named character vector of environment variables, or `NULL`.
#' @param echo Logical; if `TRUE`, print stdout/stderr as it is produced.
#'   Default `FALSE`.
#' @param error_on_status Logical; if `TRUE` (default), stop with an error
#'   when rclone exits with a non-zero status.
#' @return A list with elements `status`, `stdout`, `stderr`, and `timeout`
#'   (invisibly).
#' @export
#' @examplesIf rclone_available()
#' rclone("version")
#' \dontrun{
#' rclone(c("ls", "myremote:mybucket"))
#' }
rclone <- function(args = character(),
                   env = NULL,
                   echo = FALSE,
                   error_on_status = TRUE) {

  bin <- rclone_binary()
  if (!fs::file_exists(bin)) {
    stop(
      "rclone binary not found. Install it with install_rclone() ",
      "or from <https://rclone.org/install/>.",
      call. = FALSE
    )
  }

  if (length(args) == 1L) {
    args <- strsplit(trimws(args), "\\s+")[[1]]
  }

  result <- processx::run(
    command          = bin,
    args             = args,
    env              = env,
    echo_cmd         = echo,
    echo             = echo,
    error_on_status  = FALSE,
    stderr_to_stdout = FALSE
  )

  if (error_on_status && result$status != 0L) {
    stop("rclone exited with status ", result$status, "\n",
         result$stderr, call. = FALSE)
  }

  invisible(result)
}
