#!/bin/bash

NAME=console-proxy-node
ASSETS="static/index.html static/tty.js package.json"


set -e

VERSION=${VERSION##v}
ARCH=$(uname -p)
WORKDIR=$(pwd)
PKGNAME="${NAME}-${VERSION}-${BUILD_NUMBER}-${ARCH}"

echo "Building version ${VERSION}"

# Lint
coffeelint --report jslint server.coffee \
    | sed -e 's/\?>/\?>\n/g' -e 's/lineEnd=undefined//g' \
    | tee jslint.xml

# Create dist dir
rm -rf build artifacts
mkdir -p "build/${PKGNAME}/static" artifacts

# Compile
coffee -o "build/${PKGNAME}/" -c server.coffee

# Copy assets
for file in $ASSETS; do
    cp "${file}" "build/${PKGNAME}/$file"
done

# Run install script
cd "build/${PKGNAME}"
npm install
cd $WORKDIR

# Archive
tar czf "artifacts/${PKGNAME}.tar.gz" "build/${PKGNAME}"
md5sum "artifacts/${PKGNAME}.tar.gz" > "artifacts/${PKGNAME}.tar.gz.md5sum"
