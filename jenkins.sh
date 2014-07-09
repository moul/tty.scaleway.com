#!/bin/bash

PWD=$(pwd)
for dir in tty.js; do
    cd "$PWD/$dir"
    ./jenkins.sh
done

rm -rf artifacts
mkdir artifacts
mv */artifacts/* artifacts
