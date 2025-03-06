#!/bin/bash
#
if [ -z "$1" ]; then
    echo "Usage: $0 <search_path>"
    exit 1
fi

SEARCH_PATH="$1"
export LC_NUMERIC=C

# Header
echo "Day(s) ago |       Date       | File Count | Total Size (GB)"
echo "-----------------------------------------------------------"

# Initialize totals
file_count_total=0
file_size_total=0

# Loop over each day range (0 to 999 days)
for days in {0..999}; do
    file_count=$(find "$SEARCH_PATH" -type f -mtime $days | wc -l)
    total_size=$(find "$SEARCH_PATH" -type f -mtime $days -exec du -b {} + | awk '{sum+=$1} END {print sum/1024/1024/1024}')

    # Accumulate totals (use correct arithmetic syntax in bash)
    ((file_count_total += file_count))
    file_size_total=$(awk -v t="$file_size_total" -v s="$total_size" 'BEGIN {print t + s}')

    if [ "$file_count" -gt 0 ]; then
        file_date=$(date -d "$days days ago" "+%Y-%m-%d")
        printf "%10d | %15s | %10d | %10.2f GB\\n" "$days" "$file_date" "$file_count" "$total_size"
    fi
done

# Final total summary
echo "-----------------------------------------------------------"
printf "%10s | %15s | %10d | %10.2f GB\\n" "Total" "all days" "$file_count_total" "$file_size_total"