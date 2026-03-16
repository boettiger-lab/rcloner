# Output file content to R

Reads the content of a remote file and returns it as a character string,
analogous to `cat` on the command line.

## Usage

``` r
rclone_cat(path)
```

## Arguments

- path:

  Remote path to the file.

## Value

Character string with the file content.

## Examples

``` r
if (FALSE) { # \dontrun{
txt <- rclone_cat("myremote:bucket/readme.txt")
cat(txt)
} # }
```
