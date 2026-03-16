# Move files between remotes or local paths

Moves files from `src` to `dest`. Source files are deleted after a
successful transfer.

## Usage

``` r
rclone_move(src, dest, progress = FALSE, ...)
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
