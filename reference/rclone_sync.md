# Sync a source to a destination

Makes `dest` identical to `src`, **deleting** files in `dest` that are
not in `src`. Use
[`rclone_copy()`](https://boettiger-lab.github.io/rcloner/reference/rclone_copy.md)
if you do not want deletions.

## Usage

``` r
rclone_sync(src, dest, progress = FALSE, ...)
```

## Arguments

- src:

  Source path (local or remote).

- dest:

  Destination path (local or remote).

- progress:

  Logical; show transfer progress. Default `FALSE`.

- ...:

  Additional rclone flags as character strings.

## Value

Invisibly, the rclone result list.

## Examples

``` r
if (FALSE) { # \dontrun{
rclone_sync("myremote:bucket", "/local/backup")
} # }
```
