#!/bin/bash

WORKDIR=$(pwd)
for dir in tty.js; do
    cd "$PWD/$dir"
    ./jenkins.sh
done

cd "$WORKDIR"
rm -rf artifacts
mkdir artifacts
mv */artifacts/* artifacts
