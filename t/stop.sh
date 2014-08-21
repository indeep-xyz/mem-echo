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

# echo to PIPE file for stop processing
echo stop >$MY_PIPE
