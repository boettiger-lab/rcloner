# Package index

## Binary installation

Install and locate the rclone binary.

- [`install_rclone()`](https://boettiger-lab.github.io/rcloner/reference/install_rclone.md)
  : Install the rclone binary

## Low-level interface

Run any rclone command directly.

- [`rclone()`](https://boettiger-lab.github.io/rcloner/reference/rclone.md)
  : Run an rclone command

## Remote configuration

Create and manage cloud storage remotes.

- [`rclone_config_create()`](https://boettiger-lab.github.io/rcloner/reference/rclone_config_create.md)
  : Configure an rclone remote
- [`rclone_config_set()`](https://boettiger-lab.github.io/rcloner/reference/rclone_config_set.md)
  : Set individual parameters on an existing remote
- [`rclone_config_show()`](https://boettiger-lab.github.io/rcloner/reference/rclone_config_show.md)
  : Show rclone configuration
- [`rclone_config_delete()`](https://boettiger-lab.github.io/rcloner/reference/rclone_config_delete.md)
  : Delete an rclone remote
- [`rclone_listremotes()`](https://boettiger-lab.github.io/rcloner/reference/rclone_listremotes.md)
  : List configured remotes

## Listing and metadata

List objects and retrieve metadata.

- [`rclone_ls()`](https://boettiger-lab.github.io/rcloner/reference/rclone_ls.md)
  : List objects in a remote path
- [`rclone_lsd()`](https://boettiger-lab.github.io/rcloner/reference/rclone_lsd.md)
  : List directories in a remote path
- [`rclone_stat()`](https://boettiger-lab.github.io/rcloner/reference/rclone_stat.md)
  : Get metadata for a single object
- [`rclone_size()`](https://boettiger-lab.github.io/rcloner/reference/rclone_size.md)
  : Get total size of a remote path

## File transfer

Copy, move, and synchronise files.

- [`rclone_copy()`](https://boettiger-lab.github.io/rcloner/reference/rclone_copy.md)
  : Copy files between remotes or local paths
- [`rclone_move()`](https://boettiger-lab.github.io/rcloner/reference/rclone_move.md)
  : Move files between remotes or local paths
- [`rclone_sync()`](https://boettiger-lab.github.io/rcloner/reference/rclone_sync.md)
  : Sync a source to a destination
- [`rclone_copyurl()`](https://boettiger-lab.github.io/rcloner/reference/rclone_copyurl.md)
  : Copy a URL directly to a remote

## File operations

Read, create, and delete files and directories.

- [`rclone_cat()`](https://boettiger-lab.github.io/rcloner/reference/rclone_cat.md)
  : Output file content to R
- [`rclone_mkdir()`](https://boettiger-lab.github.io/rcloner/reference/rclone_mkdir.md)
  : Create a directory or bucket
- [`rclone_rmdir()`](https://boettiger-lab.github.io/rcloner/reference/rclone_rmdir.md)
  : Remove an empty directory
- [`rclone_delete()`](https://boettiger-lab.github.io/rcloner/reference/rclone_delete.md)
  : Delete files at a remote path
- [`rclone_purge()`](https://boettiger-lab.github.io/rcloner/reference/rclone_purge.md)
  : Remove a path and all its contents

## Utilities

Miscellaneous rclone utilities.

- [`rclone_check()`](https://boettiger-lab.github.io/rcloner/reference/rclone_check.md)
  : Check whether two remotes are in sync
- [`rclone_link()`](https://boettiger-lab.github.io/rcloner/reference/rclone_link.md)
  : Generate a public link for a remote file
- [`rclone_about()`](https://boettiger-lab.github.io/rcloner/reference/rclone_about.md)
  : Get quota information for a remote
- [`rclone_version()`](https://boettiger-lab.github.io/rcloner/reference/rclone_version.md)
  : Show rclone version information
