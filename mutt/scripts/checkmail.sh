#!/bin/bash
set -euo pipefail
#set -x

STATE=`nmcli networking connectivity`

if [[ $STATE = "full" ]]
then
  /usr/bin/mbsync -a -c ~/.mbsyncrc 2>/dev/null
  exit 0
fi

echo "No Internet connection."
exit 0
