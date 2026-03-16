# List objects in a remote path

Returns a data frame of objects at the given path, parsed from rclone's
JSON output. This is the primary listing function and maps to
`rclone lsjson`.

## Usage

``` r
rclone_ls(path, recursive = FALSE, dirs_only = FALSE, files_only = FALSE, ...)
```

## Arguments

- path:

  Remote path in rclone syntax, e.g. `"myremote:bucket/prefix"`. For
  local paths use the filesystem path directly.

- recursive:

  Logical; if `TRUE`, list all objects recursively. Default `FALSE`.

- dirs_only:

  Logical; if `TRUE`, list only directories. Default `FALSE`.

- files_only:

  Logical; if `TRUE`, list only files (no directories). Default `FALSE`.

- ...:

  Additional flags passed to `rclone lsjson` as strings (e.g.
  `"--fast-list"`).

## Value

A data frame with columns `Path`, `Name`, `Size`, `MimeType`, `ModTime`,
`IsDir`, and optionally others returned by rclone.

## Examples

``` r
if (FALSE) { # \dontrun{
rclone_ls("myremote:mybucket")
rclone_ls("myremote:mybucket/prefix", recursive = TRUE)
} # }
```
