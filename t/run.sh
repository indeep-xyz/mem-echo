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
MEM_ECHO="$MY_DIR/../mem-echo.sh"

TEXT="`create_text`"

# - - - - - - - - - - - - - - - - - - - -
# main

# run as daemon
echo -e "$TEXT" | "$MEM_ECHO" "$MY_PIPE"
