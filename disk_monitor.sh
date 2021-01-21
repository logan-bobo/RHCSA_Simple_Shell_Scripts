#!/bin/bash

#Scan for large directories and produce a report with a date and time stamp

CHECK_DIRECTORIES=" /var/log /home"

DATE=$(date '+%m%d%y')

exec > disk_used_$DATE.rpt

echo "Top 10 Disk Space usage"
echo "Dor $CHECK_DIRECTORIES directories"


for DIR_CHECK in $CHECK_DIRECTORIES
do
  echo ""
  echo "Directory - $DIR_CHECK"
  du -Sh $DIR_CHECK 2>/dev/null |
  sort -rn |
  sed '{11,$D; =}' |
  sed 'N; s/\n/ /' |
  gawk '{printf $1 ":" "\t" $2 "\t" $3 "\n"}'
done

exit
