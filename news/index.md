# Changelog

## rcloner 0.0.1

- Initial release providing an R interface to the ‘rclone’ command-line
  utility.
- [`install_rclone()`](https://boettiger-lab.github.io/rcloner/reference/install_rclone.md)
  downloads the appropriate rclone binary for the current platform.
- [`rclone()`](https://boettiger-lab.github.io/rcloner/reference/rclone.md)
  provides a low-level interface to any rclone subcommand.
- High-level wrappers:
  [`rclone_ls()`](https://boettiger-lab.github.io/rcloner/reference/rclone_ls.md),
  [`rclone_copy()`](https://boettiger-lab.github.io/rcloner/reference/rclone_copy.md),
  [`rclone_sync()`](https://boettiger-lab.github.io/rcloner/reference/rclone_sync.md),
  [`rclone_move()`](https://boettiger-lab.github.io/rcloner/reference/rclone_move.md),
  [`rclone_cat()`](https://boettiger-lab.github.io/rcloner/reference/rclone_cat.md),
  [`rclone_mkdir()`](https://boettiger-lab.github.io/rcloner/reference/rclone_mkdir.md),
  [`rclone_rmdir()`](https://boettiger-lab.github.io/rcloner/reference/rclone_rmdir.md),
  [`rclone_delete()`](https://boettiger-lab.github.io/rcloner/reference/rclone_delete.md),
  [`rclone_purge()`](https://boettiger-lab.github.io/rcloner/reference/rclone_purge.md),
  [`rclone_stat()`](https://boettiger-lab.github.io/rcloner/reference/rclone_stat.md),
  [`rclone_size()`](https://boettiger-lab.github.io/rcloner/reference/rclone_size.md),
  [`rclone_check()`](https://boettiger-lab.github.io/rcloner/reference/rclone_check.md),
  [`rclone_link()`](https://boettiger-lab.github.io/rcloner/reference/rclone_link.md),
  [`rclone_about()`](https://boettiger-lab.github.io/rcloner/reference/rclone_about.md),
  [`rclone_version()`](https://boettiger-lab.github.io/rcloner/reference/rclone_version.md).
- Configuration helpers:
  [`rclone_config_create()`](https://boettiger-lab.github.io/rcloner/reference/rclone_config_create.md),
  [`rclone_config_set()`](https://boettiger-lab.github.io/rcloner/reference/rclone_config_set.md),
  [`rclone_config_show()`](https://boettiger-lab.github.io/rcloner/reference/rclone_config_show.md),
  [`rclone_config_delete()`](https://boettiger-lab.github.io/rcloner/reference/rclone_config_delete.md),
  [`rclone_listremotes()`](https://boettiger-lab.github.io/rcloner/reference/rclone_listremotes.md).
