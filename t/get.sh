#!/bin/bash

# - - - - - - - - - - - - - - - - - - - -
# initialize

MY_DIR="`readlink -f "$0" | sed 's!/[^/]*$!!'`"
MY_PIPE="$MY_DIR/mypipe"
MEM_ECHO="$MY_DIR/../mem-echo.sh"

# - - - - - - - - - - - - - - - - - - - -
# main

# guard
# - require PIPE file
[ ! -p "$MY_PIPE" ] && exit 1

# pass the user signal to mem-echo
if [ "$1" = "1" ]; then
  echo 1 >$MY_PIPE
else
  echo 0 >$MY_PIPE
fi

# echo from pipe file
cat <$MY_PIPE
