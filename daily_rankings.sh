#!/usr/bin/env bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# Usage: daily_rankings.sh {path_to_m-c_log_file}
# - Creates a directory for log files
# - Normalizes them
# - Runs top 40 on them

SCRIPT_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
FILE=$1

# If a it's a full path pull off the log file
if [ "${FILE: -6}" == "txt.gz" ]; then
  FILE=`dirname ${FILE}`/
fi

TIMESTAMP=`basename ${FILE}`

DATE=`date -d @$TIMESTAMP +%Y-%m-%d`
mkdir $DATE
cd $DATE

"$SCRIPT_ROOT/get_logs.sh" $FILE
"$SCRIPT_ROOT/normalize.sh" *.txt
"$SCRIPT_ROOT/rankings.sh"

echo ""
TOTAL_WARNING_COUNT=`cat *.txt | grep -c 'WARNING:'`
echo "TOTAL WARNING COUNT = $TOTAL_WARNING_COUNT"