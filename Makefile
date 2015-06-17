NAME =                  console-proxy-node
ASSETS =                static/index.html static/tty.js package.json static/term-ocs.js
WORKDIR :=              $(PWD)
ARCH :=                 $(shell uname -p)
VERSION :=              $(shell cat package.json  | grep version | cut -d'"' -f4)
BUILDER_NUMBER ?=       manual
PKGNAME =               $(NAME)-$(VERSION)-$(BUILD_NUMBER)-$(ARCH)


all: build


.PHONY: lint
lint: node_modules/.bin/coffeelint
	./node_modules/.bin/coffeelint --report jslint server.coffee \
	    | sed -e 's/\?>/\?>\n/g' -e 's/lineEnd=undefined//g' \
	    | tee jslint.xml


.PHONY: build
build: node_modules/.bin/coffee node_modules
	rm -rf build artifacts
	mkdir -p "build/$(PKGNAME)/static" "artifacts"

	./node_modules/.bin/coffee -o "build/$(PKGNAME)/" -c server.coffee

	for file in $(ASSETS); do \
	    cp "$$file" "build/$(PKGNAME)/$$file"; \
	done

	cd "build/$(PKGNAME)"; npm install


.PHONY: jenkins
jenkins: build
	# Archive
	tar czf "artifacts/$(PKGNAME).tar.gz" -C "build/$(PKGNAME)/" "."
	md5sum "artifacts/$(PKGNAME).tar.gz" > "artifacts/$(PKGNAME).tar.gz.md5sum"


.PHONY: up
up:
	docker-compose up -d
	docker-compose logs


# Deps
node_modules: package.json
	npm install --no-optional

node_modules/.bin/coffeelint:
	npm install coffeelint

node_modules/.bin/coffee:
	npm install coffee-script
