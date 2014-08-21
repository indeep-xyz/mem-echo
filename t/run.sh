#!/bin/bash

# - - - - - - - - - - - - - - - - - - - -
# functions

create_text() {

  for i in `seq 5`
  do
    echo $RANDOM
  done
}

# - - - - - - - - - - - - - - - - - - - -
# initialize

MY_DIR="`readlink -f "$0" | sed 's!/[^/]*$!!'`"
MY_PIPE="$MY_DIR/mypipe"
MY_PID="$MY_DIR/pid"
MEM_ECHO="$MY_DIR/../mem-echo.sh"

TEXT="`create_text`"

# - - - - - - - - - - - - - - - - - - - -
# main

echo -e "$TEXT" | "$MEM_ECHO" "$MY_PIPE" "$MY_PID"
