#!/bin/bash

npm --color false install
coffeelint --jslint server.coffee | sed -e 's/\?>/\?>\n/g' -e 's/lineEnd=undefined//g'| tee jslint.xml
