# Delete files at a remote path

Deletes the files (not directories) at the given path. To remove a
directory and all its contents use
[`rclone_purge()`](https://boettiger-lab.github.io/rcloner/reference/rclone_purge.md).

## Usage

``` r
rclone_delete(path, ...)
```

## Arguments

- path:

  Remote path to delete.

- ...:

  Additional rclone flags.

## Value

Invisibly, the rclone result list.
