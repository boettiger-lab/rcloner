# Check whether two remotes are in sync

Compares the files in `src` and `dest` without transferring anything.
Differences are reported as messages.

## Usage

``` r
rclone_check(src, dest, ...)
```

## Arguments

- src:

  Source path.

- dest:

  Destination path.

- ...:

  Additional rclone flags.

## Value

Invisibly, the rclone result list (check stderr for differences).
