#!/bin/bash

# - - - - - - - - - - - - - - - - - - - -
# initialize

MY_DIR="`readlink -f "$0" | sed 's!/[^/]*$!!'`"
MY_PIPE="$MY_DIR/mypipe"
MY_PID="$MY_DIR/pid"
MEM_ECHO="$MY_DIR/../mem-echo.sh"

PID="`cat $MY_PID`"

# - - - - - - - - - - - - - - - - - - - -
# main

# guard
# - require PID data
[ -z "$PID" ] && exit 1

# pass the user signal to mem-echo
if [ "$1" = "1" ]; then
  kill -SIGUSR1 $PID
else
  kill -SIGUSR2 $PID
fi

# echo from pipe file
cat <$MY_PIPE
