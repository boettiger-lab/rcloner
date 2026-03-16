## R CMD check results

0 errors | 0 warnings | 1 note

* The note "unable to verify current time" is a transient network check
  unrelated to the package.

## CRAN policies

* All examples use `\dontrun{}` or `\donttest{}` for code that requires
  network access or credentials.
* Tests that require the `rclone` binary or network access are wrapped in
  `skip_on_cran()` and `skip_if_not(nzchar(Sys.which("rclone")))`.
* The vignette uses `eval = nzchar(Sys.which("rclone"))` so it builds
  correctly on CRAN without requiring rclone.
* `install_rclone()` is called only on explicit user request; the package
  does not download files at load time or during tests without user
  consent.
