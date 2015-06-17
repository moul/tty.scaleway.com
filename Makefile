NAME =                  console-proxy-node
ASSETS =                static/index.html static/tty.js package.json static/term-ocs.js
WORKDIR :=              $(PWD)
ARCH :=                 $(shell uname -p)
VERSION :=              $(shell cat package.json  | grep version | cut -d'"' -f4)
BUILDER_NUMBER ?=       manual
PKGNAME =               $(NAME)-$(VERSION)-$(BUILD_NUMBER)-$(ARCH)

jenkins:
	@echo "Building version ${VERSION}"

	# Lint
	coffeelint --report jslint server.coffee \
	    | sed -e 's/\?>/\?>\n/g' -e 's/lineEnd=undefined//g' \
	    | tee jslint.xml

	# Create dist dir
	rm -rf build artifacts
	mkdir -p "build/$(PKGNAME)/static" "artifacts"

	# Compile
	coffee -o "build/$(PKGNAME)/" -c server.coffee

	# Copy assets
	for file in $(ASSETS); do \
	    cp "$$file" "build/$(PKGNAME)/$$file"; \
	done

	# Run install script
	cd "build/$(PKGNAME)"; npm install

	# Archive
	tar czf "artifacts/$(PKGNAME).tar.gz" -C "build/$(PKGNAME)/" "."
	md5sum "artifacts/$(PKGNAME).tar.gz" > "artifacts/$(PKGNAME).tar.gz.md5sum"


up:
	docker-compose up -d
	docker-compose logs
