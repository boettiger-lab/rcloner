## Resubmission

This is a resubmission addressing the following issues raised by CRAN:

### 1. Vignette executed no code

The vignette previously set `eval = nzchar(Sys.which("rclone"))` globally,
which silenced all chunks on systems without rclone (including CRAN). Fixed
by removing the global eval condition and restructuring the setup chunk to
call `rclone_available()` unconditionally. This always executes, prints a
message when rclone is absent, and sets `has_rclone` used by subsequent
chunks via `eval = has_rclone`. Those chunks are skipped silently when
rclone is not installed — no errors, no warnings.

### 2. Functions must not install software

The internal `rclone()` dispatcher previously called `install_rclone()`
automatically when the binary was missing. Removed. A clear error message
directing users to `install_rclone()` is raised instead.

All examples that invoke rclone are guarded by `@examplesIf
rclone_available()`, which is `FALSE` on CRAN (no rclone present), so no
example triggers installation or produces an error.

### 3. Incorrect `\examplesIf` Rd syntax

Examples were using `\examplesIf{condition}` inside `@examples` blocks
rather than the `@examplesIf condition` roxygen tag. All instances replaced
with the proper tag, eliminating the "unknown macro" warnings during build.

---

## R CMD check results

0 errors | 0 warnings | 0 notes

## CRAN policies

* Examples that require the rclone binary are guarded with
  `@examplesIf rclone_available()` and skipped when rclone is absent.
* `\dontrun{}` is used for examples requiring credentials or network access.
* Tests that require the rclone binary or network access are wrapped in
  `skip_on_cran()` and `skip_if_not(rclone_available())`.
* `install_rclone()` is only invoked on explicit user request; the package
  does not download or install anything at load time, during tests, or in
  examples/vignettes.
