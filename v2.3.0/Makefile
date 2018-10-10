# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    deps   Install dependencies"
	@echo "    serve  Start local server"
	@echo "    build  Start local server"
	@echo ""
	@echo "  Variables"
	@echo ""

# END-EVAL

.PHONY: swagger yaml data/ocrd.oas3.json

# Install dependencies
deps:
	bundle install

# Start local server
serve:
	bundle exec jekyll serve --incremental

# Build the site in a _site directory
build:
	bundle exec jekyll build
