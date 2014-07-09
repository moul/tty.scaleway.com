#!/bin/bash

set -e

npm --color false install
coffeelint --report jslint server.coffee | sed -e 's/\?>/\?>\n/g' -e 's/lineEnd=undefined//g'| tee jslint.xml

rm -rf dist artifacts
mkdir -p dist/static artifacts

coffee -o dist/ -c server.coffee

for file in static/index.html static/tty.js package.json; do
    cp "$file" "dist/$file"
done

PWD=$(pwd)

cd dist
npm install
cd ..

tar czf artifacts/dist.tgz dist
