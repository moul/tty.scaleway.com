#!/bin/bash

PWD=$(pwd)
for dir in tty.js; do
    cd "$PWD/$dir"
    ./jenkins.sh
done
