## Resubmission

This resubmission addresses the issues raised by CRAN:

* The vignette now executes code on all systems. Chunks requiring rclone
  are conditioned on `rclone_available()` and skipped silently when rclone
  is absent.
* Functions no longer install software. `install_rclone()` is only invoked
  on explicit user request.
* All examples requiring rclone are guarded with `@examplesIf rclone_available()`
  and skipped when rclone is not installed.

## R CMD check results

0 errors | 0 warnings | 0 notes
