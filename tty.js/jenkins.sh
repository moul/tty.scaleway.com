#!/bin/bash

set -e

NAME=ttyjs
ASSETS="static/index.html static/tty.js package.json"

# Lint
coffeelint --report jslint server.coffee \
    | sed -e 's/\?>/\?>\n/g' -e 's/lineEnd=undefined//g' \
    | tee jslint.xml

# Create dist dir
rm -rf "$NAME" artifacts
mkdir -p "$NAME/static" artifacts

# Compile
coffee -o "$NAME/" -c server.coffee

# Copy assets
for file in $ASSETS; do
    cp "$file" "$NAME/$file"
done

# Run install script
cd "$NAME"
npm install
cd ..

# Archive
tar czf "artifacts/$NAME.tgz" "$NAME"
