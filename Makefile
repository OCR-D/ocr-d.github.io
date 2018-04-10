SHELL := /bin/bash

# Swagger version ("$(SWAGGER_UI_VERSION)")
SWAGGER_UI_VERSION = 3.13.2

# Arguments to ocrd generate-swagger. ("$(OCRD_TOOLS)")
OCRD_TOOLS = -T ../ocrd_tesserocr/ocrd-tool.json

SWAGGER_UI_URL = https://github.com/swagger-api/swagger-ui/archive/v$(SWAGGER_UI_VERSION).zip

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    swagger  Fetch swagger"
	@echo "    yaml     Rebuild YAML"
	@echo "    serve    Start local server"
	@echo ""
	@echo "  Variables"
	@echo ""
	@echo "    SWAGGER_UI_VERSION  Swagger version ("$(SWAGGER_UI_VERSION)")"
	@echo "    OCRD_TOOLS          Arguments to ocrd generate-swagger. ("$(OCRD_TOOLS)")"

# END-EVAL

.PHONY: swagger yaml docs/ocrd.oas3.yml

# Fetch swagger
swagger: docs/swagger docs/ocrd.oas3.yml

docs/swagger:
	mkdir -p docs
	cd docs ;\
		if [[ ! -e "v$(SWAGGER_UI_VERSION).zip" ]];then wget "$(SWAGGER_UI_URL)"; fi; \
		rm -rf openapi; \
		if [[ ! -e 'openapi' ]];then \
			unzip v$(SWAGGER_UI_VERSION).zip;\
			mv swagger-ui-$(SWAGGER_UI_VERSION)/dist openapi; \
			rm -rf swagger-ui-$(SWAGGER_UI_VERSION); \
		fi

# Rebuild YAML
yaml: docs/ocrd.oas3.yml

docs/ocrd.oas3.yml:
	sed -i '/url:/ s|.*|url: "http://kba.cloud/ocr-d.github.io/ocrd.oas3.yml",|' docs/openapi/index.html
	ocrd generate-swagger $(OCRD_TOOLS) | traf -i json -o yaml - $@

# Start local server
serve:
	sed -i '/url:/ s|.*|url: "http://localhost:8000/ocrd.oas3.yml",|' docs/openapi/index.html
	cd docs ; python -m SimpleHTTPServer
