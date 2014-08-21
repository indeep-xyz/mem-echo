mem-echo
=====

this shell script hold the text data from STDIN. the held data is echoed to pipe file by user signals.

## USAGE

### run

```
{SourceText} | mem-echo {PipeFilePath} {PidFilePath}
```

### get text

```
cat <{PipeFilePath} &

# random a line
kill -SIGUSR1 {PidOfRunningMemEcho}

# full text
kill -SIGUSR2 {PidOfRunningMemEcho}
```

### stop

```
kill -INT {PidOfRunningMemEcho}
```

## AUTHOR

[indeep-xyz](http://indeep.xyz/)
