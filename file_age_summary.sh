#!/bin/bash
#
# Check if path parameter is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <search_path>"
    exit 1
fi

SEARCH_PATH="$1"

# Last 20 days
echo "Files modified in the last 20 days:"
find "$SEARCH_PATH" -type f -mtime -20 -print0 | xargs -0 ls -l | awk '{count++; total += $5} END {print "Count:", count; print "Total size:", total/1024/1024, "MB"}'

# 20-50 days
echo "Files modified between 20 and 50 days ago:"
find "$SEARCH_PATH" -type f -mtime +20 -mtime -50 -print0 | xargs -0 ls -l | awk '{count++; total += $5} END {print "Count:", count; print "Total size:", total/1024/1024, "MB"}'

# 50-100 days
echo "Files modified between 50 and 100 days ago:"
find "$SEARCH_PATH" -type f -mtime +50 -mtime -100 -print0 | xargs -0 ls -l | awk '{count++; total += $5} END {print "Count:", count; print "Total size:", total/1024/1024, "MB"}'

# 100-200 days
echo "Files modified between 100 and 200 days ago:"
find "$SEARCH_PATH" -type f -mtime +100 -mtime -200 -print0 | xargs -0 ls -l | awk '{count++; total += $5} END {print "Count:", count; print "Total size:", total/1024/1024, "MB"}'

# Older than 200 days
echo "Files modified more than 200 days ago:"
find "$SEARCH_PATH" -type f -mtime +200 -print0 | xargs -0 ls -l | awk '{count++; total += $5} END {print "Count:", count; print "Total size:", total/1024/1024, "MB"}'