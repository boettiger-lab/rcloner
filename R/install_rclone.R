#' Install the rclone binary
#'
#' Downloads and installs the rclone binary for the current platform.
#' The binary is stored in a user-writable directory and does not require
#' system-level installation.
#'
#' @param force Logical; if `TRUE`, re-download even if rclone is already
#'   installed. Default `FALSE`.
#' @param dest Directory in which to install rclone. Defaults to the value of
#'   `options("rcloner.dir")`, falling back to `tools::R_user_dir("rcloner",
#'   "data")`.
#' @return Invisibly, the path to the installed rclone binary.
#' @export
#' @examples
#' \dontrun{
#' install_rclone()
#' }
install_rclone <- function(force = FALSE,
                           dest = getOption("rcloner.dir",
                                            tools::R_user_dir("rcloner", "data"))) {
  binary <- rclone_binary(dest)
  if (!force && fs::file_exists(binary)) {
    message("rclone already installed at ", binary)
    return(invisible(binary))
  }

  os   <- rclone_os()
  arch <- rclone_arch()
  url  <- paste0("https://downloads.rclone.org/rclone-current-", os, "-", arch, ".zip")

  tmp_zip <- tempfile(fileext = ".zip")
  tmp_dir <- tempdir()

  message("Downloading rclone from ", url)
  utils::download.file(url, tmp_zip, mode = "wb", quiet = FALSE)

  utils::unzip(tmp_zip, exdir = tmp_dir)

  # The zip extracts to rclone-vX.Y.Z-os-arch/rclone[.exe]
  bin_name <- if (os == "windows") "rclone.exe" else "rclone"
  extracted <- Sys.glob(file.path(tmp_dir, paste0("rclone-*-", os, "-", arch), bin_name))
  if (length(extracted) == 0) {
    stop("Could not find rclone binary in extracted archive")
  }

  fs::dir_create(dest, recurse = TRUE)
  fs::file_copy(extracted[1], binary, overwrite = TRUE)
  if (os != "windows") {
    fs::file_chmod(binary, "0755")
  }

  message("rclone installed at ", binary)
  invisible(binary)
}

#' @keywords internal
rclone_binary <- function(dir = getOption("rcloner.dir",
                                          tools::R_user_dir("rcloner", "data"))) {
  bin <- if (.Platform$OS.type == "windows") "rclone.exe" else "rclone"
  # If there's a system rclone and no local install preference, use it
  if (!fs::dir_exists(dir)) {
    sys <- Sys.which("rclone")
    if (nzchar(sys)) return(unname(sys))
  }
  file.path(dir, bin)
}

#' @keywords internal
rclone_os <- function() {
  si <- Sys.info()
  sysname <- si[["sysname"]]
  if (grepl("linux", sysname, ignore.case = TRUE)) return("linux")
  if (grepl("darwin|mac", sysname, ignore.case = TRUE)) return("osx")
  if (grepl("windows", sysname, ignore.case = TRUE)) return("windows")
  stop("Unsupported operating system: ", sysname)
}

#' @keywords internal
rclone_arch <- function() {
  machine <- Sys.info()[["machine"]]
  if (grepl("x86_64|amd64", machine, ignore.case = TRUE)) return("amd64")
  if (grepl("aarch64|arm64", machine, ignore.case = TRUE)) return("arm64")
  if (grepl("armv7|armhf",   machine, ignore.case = TRUE)) return("arm-v7")
  if (grepl("i386|i686",     machine, ignore.case = TRUE)) return("386")
  stop("Unsupported architecture: ", machine)
}
