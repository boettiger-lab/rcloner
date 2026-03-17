# Getting started with rcloner

``` r
library(rcloner)
```

## Overview

`rcloner` provides an R interface to [rclone](https://rclone.org), a
command-line program that supports over 40 cloud storage backends,
including:

- **S3-compatible** stores: Amazon S3, MinIO, Ceph, Cloudflare R2,
  Backblaze B2, …
- **Google Cloud Storage** and Google Drive
- **Azure Blob Storage**
- **Dropbox**, **OneDrive**, **Box**, and many others

All file operations (copy, sync, list, move, delete, …) use the same
consistent interface regardless of the storage backend.

## Installation

Install from CRAN:

``` r
install.packages("rcloner")
```

Or the development version from GitHub:

``` r
# install.packages("pak")
pak::pak("boettiger-lab/rcloner")
```

### Installing the rclone binary

`rcloner` automatically locates a system-installed rclone binary. If
rclone is not already on your `PATH`, install it with:

``` r
install_rclone()
```

This downloads the appropriate pre-built binary from
<https://downloads.rclone.org> for your operating system and
architecture and stores it in a user-writable directory — no system
privileges required.

Check the installed version:

``` r
rclone_version()
```

## Configuring a remote

`rcloner` manages cloud storage credentials through *remotes*, which are
named configurations stored in rclone’s config file.

### Amazon S3

``` r
rclone_config_create(
  "aws",
  type     = "s3",
  provider = "AWS",
  access_key_id     = Sys.getenv("AWS_ACCESS_KEY_ID"),
  secret_access_key = Sys.getenv("AWS_SECRET_ACCESS_KEY"),
  region            = "us-east-1"
)
```

### MinIO / S3-compatible

``` r
rclone_config_create(
  "minio",
  type     = "s3",
  provider = "Minio",
  access_key_id     = Sys.getenv("MINIO_ACCESS_KEY"),
  secret_access_key = Sys.getenv("MINIO_SECRET_KEY"),
  endpoint          = "https://minio.example.com"
)
```

### Listing configured remotes

``` r
rclone_listremotes()
```

## Listing objects

[`rclone_ls()`](https://boettiger-lab.github.io/rcloner/reference/rclone_ls.md)
returns a data frame of objects at a given path.

### Local paths (no credentials needed)

``` r
# List a local directory
rclone_ls(tempdir(), files_only = TRUE)
```

### Remote paths

``` r
# List a bucket on a configured remote
rclone_ls("aws:my-bucket")

# Recursive listing
rclone_ls("aws:my-bucket/data/", recursive = TRUE)

# Directories only
rclone_lsd("aws:my-bucket")
```

[`rclone_ls()`](https://boettiger-lab.github.io/rcloner/reference/rclone_ls.md)
parses `rclone lsjson` output and returns a data frame with columns
`Path`, `Name`, `Size`, `MimeType`, `ModTime`, and `IsDir`.

## Copying and syncing files

### Copy

[`rclone_copy()`](https://boettiger-lab.github.io/rcloner/reference/rclone_copy.md)
copies files from source to destination, skipping identical files. It
never deletes destination files.

``` r
src  <- tempfile()
dest <- tempfile()
dir.create(src)
dir.create(dest)
writeLines("hello from rcloner", file.path(src, "readme.txt"))

rclone_copy(src, dest)
list.files(dest)
```

### Copy to/from the cloud

``` r
# Upload a local directory to S3
rclone_copy("/local/data", "aws:my-bucket/data")

# Download a file from S3
rclone_copy("aws:my-bucket/report.csv", "/local/downloads/")

# Copy a URL directly to cloud storage (no local intermediate)
rclone_copyurl(
  "https://raw.githubusercontent.com/tidyverse/readr/main/inst/extdata/mtcars.csv",
  "aws:my-bucket/mtcars.csv"
)
```

### Sync

[`rclone_sync()`](https://boettiger-lab.github.io/rcloner/reference/rclone_sync.md)
makes the destination *identical* to the source, deleting destination
files that are not in the source. Use with care.

``` r
rclone_sync("aws:my-bucket/data", "/local/backup")
```

### Move

[`rclone_move()`](https://boettiger-lab.github.io/rcloner/reference/rclone_move.md)
copies files and then deletes the source.

``` r
rclone_move("aws:staging/file.csv", "aws:archive/2024/file.csv")
```

## Other file operations

``` r
# Read a remote file into R
contents <- rclone_cat("aws:my-bucket/config.yaml")

# Get metadata for an object
rclone_stat("aws:my-bucket/data.csv")

# Total size of a path
rclone_size("aws:my-bucket")

# Create a bucket/directory
rclone_mkdir("aws:new-bucket")

# Delete files (keeps directories)
rclone_delete("aws:my-bucket/old-data/")

# Remove a path and all its contents
rclone_purge("aws:my-bucket/scratch")

# Generate a public link (where supported)
rclone_link("aws:my-bucket/report.html")

# Get storage quota info
rclone_about("aws:")
```

## Using the low-level rclone() wrapper

Every rclone subcommand is accessible via the
[`rclone()`](https://boettiger-lab.github.io/rcloner/reference/rclone.md)
function, which accepts a character vector of arguments:

``` r
# Equivalent to: rclone version
rclone("version")

# Run any rclone command
rclone(c("check", "aws:bucket", "/local/backup", "--one-way"))
```

## Migrating from minioclient

If you are migrating from the `minioclient` package, the function
mapping is:

| `minioclient`    | `rcloner`                                                                                             |
|------------------|-------------------------------------------------------------------------------------------------------|
| `mc_alias_set()` | [`rclone_config_create()`](https://boettiger-lab.github.io/rcloner/reference/rclone_config_create.md) |
| `mc_cp()`        | [`rclone_copy()`](https://boettiger-lab.github.io/rcloner/reference/rclone_copy.md)                   |
| `mc_mv()`        | [`rclone_move()`](https://boettiger-lab.github.io/rcloner/reference/rclone_move.md)                   |
| `mc_mirror()`    | [`rclone_sync()`](https://boettiger-lab.github.io/rcloner/reference/rclone_sync.md)                   |
| `mc_ls()`        | [`rclone_ls()`](https://boettiger-lab.github.io/rcloner/reference/rclone_ls.md)                       |
| `mc_cat()`       | [`rclone_cat()`](https://boettiger-lab.github.io/rcloner/reference/rclone_cat.md)                     |
| `mc_mb()`        | [`rclone_mkdir()`](https://boettiger-lab.github.io/rcloner/reference/rclone_mkdir.md)                 |
| `mc_rb()`        | [`rclone_purge()`](https://boettiger-lab.github.io/rcloner/reference/rclone_purge.md)                 |
| `mc_rm()`        | [`rclone_delete()`](https://boettiger-lab.github.io/rcloner/reference/rclone_delete.md)               |
| `mc_du()`        | [`rclone_size()`](https://boettiger-lab.github.io/rcloner/reference/rclone_size.md)                   |
| `mc_stat()`      | [`rclone_stat()`](https://boettiger-lab.github.io/rcloner/reference/rclone_stat.md)                   |
| `mc()`           | [`rclone()`](https://boettiger-lab.github.io/rcloner/reference/rclone.md)                             |

The main difference is that `rcloner` uses *remotes*
(e.g. `"aws:bucket"`) rather than *aliases* (e.g. `"alias/bucket"`).
Remote configuration is done with
[`rclone_config_create()`](https://boettiger-lab.github.io/rcloner/reference/rclone_config_create.md)
instead of `mc_alias_set()`.
