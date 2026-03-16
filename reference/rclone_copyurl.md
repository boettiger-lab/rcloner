# Copy a URL directly to a remote

Downloads a URL and uploads it to `dest` without storing it locally
first.

## Usage

``` r
rclone_copyurl(url, dest, ...)
```

## Arguments

- url:

  URL to copy.

- dest:

  Destination remote path.

- ...:

  Additional rclone flags.

## Value

Invisibly, the rclone result list.
