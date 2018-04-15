SHELL := /bin/bash

# Arguments to ocrd generate-swagger. ("$(OCRD_TOOLS)")
OCRD_TOOLS = -T ../ocrd_tesserocr/ocrd-tool.json

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    deps          Install dependencies"
	@echo "    swagger       Fetch swagger"
	@echo "    swagger-json  Rebuild Swagger JSON"
	@echo "    swagger-yaml  Rebuild Swagger YAML"
	@echo "    serve         Start local server"
	@echo "    spec          Clone spec repo"
	@echo "    markdown      Copy markdown from ocr-d/spec to here"
	@echo ""
	@echo "  Variables"
	@echo ""
	@echo "    OCRD_TOOLS  Arguments to ocrd generate-swagger. ("$(OCRD_TOOLS)")"

# END-EVAL

.PHONY: swagger yaml data/ocrd.oas3.json

# Install dependencies
deps:
	npm install -g traf
	bundle install

# Fetch swagger
swagger: swagger-json swagger-yaml

# Rebuild Swagger JSON
swagger-json: data/ocrd.oas3.json

data/ocrd.oas3.json:
	mkdir -p "$(dir $@)"
	ocrd generate-swagger $(OCRD_TOOLS) > "$@"

# Rebuild Swagger YAML
swagger-yaml: swagger-json
	traf -i json -o yaml data/ocrd.oas3.json data/ocrd.oas3.yml

# Start local server
serve:
	bundle exec jekyll serve

# Clone spec repo
spec:
	git clone --depth 1 https://github.com/OCR-D/spec

# Copy markdown from ocr-d/spec to here
markdown: cli.md docker.md ocrd_tool.md mets.md

define copy_markdown
	echo -e "---\nlayout: page\n---\n\n" > "$(1)"
	cat spec/$(1) >> "$(1)"
endef

docker.md:
	$(call copy_markdown,$@)

cli.md:
	$(call copy_markdown,$@)

ocrd_tool.md:
	$(call copy_markdown,$@)

mets.md:
	$(call copy_markdown,$@)
