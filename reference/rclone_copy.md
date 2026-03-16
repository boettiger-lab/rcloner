# Copy files between remotes or local paths

Copies files from `src` to `dest`, skipping files that are identical.
Does not delete files at the destination.

## Usage

``` r
rclone_copy(src, dest, progress = FALSE, ...)
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
rclone_copy("myremote:bucket/file.csv", "/tmp/file.csv")
rclone_copy("/local/dir", "myremote:bucket/dir", progress = TRUE)
} # }
```
