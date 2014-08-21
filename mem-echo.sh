#!/bin/bash

# - - - - - - - - - - - - - - - - - - - -
# functions

mem_echo_oneline() {

  local -i line_num=$((RANDOM % TEXT_LINES + 1))
  local line="`echo -e "$TEXT" | sed -n "${line_num}p"`"

  echo "$line" > "$PIPE_PATH"
}

mem_echo_fulltext() {

  echo "$TEXT" > "$PIPE_PATH"
}

mem_init() {

  TEXT_LINES="`echo -e "$TEXT" | grep -c ''`"

  rm "$PIPE_PATH" > /dev/null 2>&1
  mkfifo $_

  echo $$ > "$PID_PATH"

  trap mem_echo_oneline SIGUSR1
  trap mem_echo_fulltext SIGUSR2
  trap mem_end INT
}

mem_end() {

  rm "$PIPE_PATH" > /dev/null 2>&1
  rm "$PID_PATH" > /dev/null 2>&1

  exit 0
}

# - - - - - - - - - - - - - - - - - - - -
# initialize

PIPE_PATH="$1"
PID_PATH="$2"
TEXT=
declare -i TEXT_LINES=0

[ -p /dev/stdin ] && TEXT="`cat -`"

# - - - - - - - - - - - - - - - - - - - -
# guard

if [ -z "$PIPE_PATH" ] || [ -z "$PID_PATH" ] || [ -z "$TEXT" ]; then

  cat <<EOT
Usage:

  run
    {SourceText} | mem-echo {PipeFilePath} {PidFilePath}

  get text (random a line)
    kill -SIGUSR1 {PidOfRunningMemEcho}
    cat <{PipeFilePath}

  get text (full text)
    kill -SIGUSR2 {PidOfRunningMemEcho}
    cat <{PipeFilePath}

  stop
    kill -INT {PidOfRunningMemEcho}
EOT
  exit 1
fi

# - - - - - - - - - - - - - - - - - - - -
# main

mem_init

while true;
do
  sleep 1
done
