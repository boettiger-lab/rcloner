# Install the rclone binary

Downloads and installs the rclone binary for the current platform. The
binary is stored in a user-writable directory and does not require
system-level installation.

## Usage

``` r
install_rclone(
  force = FALSE,
  dest = getOption("rcloner.dir", tools::R_user_dir("rcloner", "data"))
)
```

## Arguments

- force:

  Logical; if `TRUE`, re-download even if rclone is already installed.
  Default `FALSE`.

- dest:

  Directory in which to install rclone. Defaults to the value of
  `options("rcloner.dir")`, falling back to
  `tools::R_user_dir("rcloner", "data")`.

## Value

Invisibly, the path to the installed rclone binary.

## Examples

``` r
if (FALSE) { # \dontrun{
install_rclone()
} # }
```
