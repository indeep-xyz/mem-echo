#!/bin/bash

# - - - - - - - - - - - - - - - - - - - -
# functions

mem_echo_fulltext() {

  echo "$TEXT" > "$PIPE_PATH"
}

mem_echo_oneline() {

  local -i line_num=$((RANDOM % TEXT_LINES + 1))
  local line="`echo -e "$TEXT" | sed -n "${line_num}p"`"

  echo "$line" > "$PIPE_PATH"
}

mem_init() {

  TEXT_LINES="`echo -e "$TEXT" | grep -c ''`"

  rm "$PIPE_PATH" > /dev/null 2>&1
  mkfifo $_

  trap mem_end INT
}

mem_end() {

  rm "$PIPE_PATH" > /dev/null 2>&1
  exit 0
}

# - - - - - - - - - - - - - - - - - - - -
# initialize

PIPE_PATH="$1"
TEXT=
declare -i TEXT_LINES=0
SIG=

[ -p /dev/stdin ] && TEXT="`cat -`"

# - - - - - - - - - - - - - - - - - - - -
# guard

if [ -z "$PIPE_PATH" ] || [ -z "$TEXT" ]; then

  cat <<EOT
Usage:

  run
    {SourceText} | mem-echo {PipeFilePath}

  get text (random a line)
    echo 1 > {PipeFilePath}
    cat <{PipeFilePath}

  get text (full text)
    echo 0 > {PipeFilePath}
    cat <{PipeFilePath}

  stop
    echo {OtherString} > {PipeFilePath}
EOT
  exit 1
fi

# - - - - - - - - - - - - - - - - - - - -
# main

mem_init

while true;
do
  SIG="`cat <$PIPE_PATH`"

  case $SIG in
    0) mem_echo_fulltext;;
    1) mem_echo_oneline;;
    *) mem_end;;
  esac
done
