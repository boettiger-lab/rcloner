# List directories in a remote path

Convenience wrapper around
[`rclone_ls()`](https://boettiger-lab.github.io/rcloner/reference/rclone_ls.md)
that returns only directories.

## Usage

``` r
rclone_lsd(path, recursive = FALSE, ...)
```

## Arguments

- path:

  Remote path in rclone syntax, e.g. `"myremote:bucket/prefix"`. For
  local paths use the filesystem path directly.

- recursive:

  Logical; if `TRUE`, list all objects recursively. Default `FALSE`.

- ...:

  Additional flags passed to `rclone lsjson` as strings (e.g.
  `"--fast-list"`).

## Value

A data frame (see
[`rclone_ls()`](https://boettiger-lab.github.io/rcloner/reference/rclone_ls.md)).
