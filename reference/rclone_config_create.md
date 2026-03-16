# Configure an rclone remote

Creates or updates a named remote in the rclone config file. This is the
primary way to register cloud storage credentials with rclone.

## Usage

``` r
rclone_config_create(name, type, ...)
```

## Arguments

- name:

  Name for the remote (used as the prefix in paths, e.g.
  `"myremote:bucket/key"`).

- type:

  Remote type, e.g. `"s3"`, `"gcs"`, `"azureblob"`, `"drive"`. Run
  `rclone("help backends")` to see all supported types.

- ...:

  Named parameters passed to the remote configuration. For S3 remotes
  this typically includes `provider`, `access_key_id`,
  `secret_access_key`, and optionally `endpoint` (for non-AWS S3).

## Value

Invisibly, the result of the rclone command.

## Examples

``` r
if (FALSE) { # \dontrun{
# AWS S3
rclone_config_create("aws", type = "s3",
  provider = "AWS",
  access_key_id = Sys.getenv("AWS_ACCESS_KEY_ID"),
  secret_access_key = Sys.getenv("AWS_SECRET_ACCESS_KEY"),
  region = "us-east-1"
)

# MinIO / S3-compatible
rclone_config_create("minio", type = "s3",
  provider = "Minio",
  access_key_id = Sys.getenv("MINIO_ACCESS_KEY"),
  secret_access_key = Sys.getenv("MINIO_SECRET_KEY"),
  endpoint = "https://minio.example.com"
)
} # }
```
