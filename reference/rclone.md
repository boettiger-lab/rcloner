# Run an rclone command

Low-level wrapper that runs any rclone command. Higher-level functions
like
[`rclone_copy()`](https://boettiger-lab.github.io/rcloner/reference/rclone_copy.md),
[`rclone_ls()`](https://boettiger-lab.github.io/rcloner/reference/rclone_ls.md),
etc. call this internally.

## Usage

``` r
rclone(args = character(), env = NULL, echo = FALSE, error_on_status = TRUE)
```

## Arguments

- args:

  Character vector of arguments passed to rclone (the command and its
  flags). Alternatively a single space-delimited string.

- env:

  Named character vector of environment variables, or `NULL`.

- echo:

  Logical; if `TRUE`, print stdout/stderr as it is produced. Default
  `FALSE`.

- error_on_status:

  Logical; if `TRUE` (default), stop with an error when rclone exits
  with a non-zero status.

## Value

A list with elements `status`, `stdout`, `stderr`, and `timeout`
(invisibly).

## Examples

``` r
if (FALSE) { # \dontrun{
rclone("version")
rclone(c("ls", "myremote:mybucket"))
} # }
```
