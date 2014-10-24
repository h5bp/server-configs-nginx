#!/bin/bash

function dump {
    echo "### $1 START"
    while read line
    do
        if [[ $line =~ "#" ]];
        then
            # skip comments
            continue
        elif [[ $line =~ "^ *$" ]];
        then
            # skip blank lines
            continue
        elif [[ $line =~ ^(\s*)include\s*(.*)\; ]];
        then
            dump ${BASH_REMATCH[2]}
        else
            echo "$line"
        fi
    done < $1
    echo "### $1 END"
}

dump $1
