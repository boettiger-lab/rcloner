# rcloner 0.0.1

* Initial release providing an R interface to the 'rclone' command-line utility.
* `install_rclone()` downloads the appropriate rclone binary for the current platform.
* `rclone()` provides a low-level interface to any rclone subcommand.
* High-level wrappers: `rclone_ls()`, `rclone_copy()`, `rclone_sync()`, `rclone_move()`,
  `rclone_cat()`, `rclone_mkdir()`, `rclone_rmdir()`, `rclone_delete()`, `rclone_purge()`,
  `rclone_stat()`, `rclone_size()`, `rclone_check()`, `rclone_link()`, `rclone_about()`,
  `rclone_version()`.
* Configuration helpers: `rclone_config_create()`, `rclone_config_set()`,
  `rclone_config_show()`, `rclone_config_delete()`, `rclone_listremotes()`.
