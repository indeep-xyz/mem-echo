mem-echo
=====

this shell script hold the text data from STDIN. the held data is echoed to pipe file by user signals.

## USAGE

### run

```
{SourceText} | mem-echo {PipeFilePath}
```

### get text

```
# random a line
echo 1 > {PipeFilePath}

# full text
echo 0 > {PipeFilePath}

cat <{PipeFilePath}
```

### stop

```
echo {OtherString} > {PipeFilePath}
```

## AUTHOR

[indeep-xyz](http://indeep.xyz/)
