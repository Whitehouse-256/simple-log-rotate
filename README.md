# simple-log-rotate
Bash script for rotating and compressing log files

# How it works
This script moves `logfile` to first non-existing `logfile.N` where `N` is an integer, when `logfile` is larger than predefined constant. The script then creates an empty `logfile` and compresses the moved `logfile.N` with `xz` command creating `logfile.N.xz`.

# Usage
Use absolute path in `ROTATE_FILE_NAME` constant, set threshold megabytes in `ROTATE_THRESHOLD_MEGS` constant and then use for example `crontab` to run the bash script every night or every hour, however often you want it to check logs.
