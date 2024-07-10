# Build .env files for each example app
build_file_from_sample = if [ ! -e $(1) ]; then cp $(1)-sample $(1); echo "Created $(1)"; else echo "Already built $(1)"; fi
EXAMPLES = legacy-settings multi-app zero-config fully-loaded
.PHONY: .env
.env:
	@echo "------ Create .env files from .env-samples"
	@for dir in $(shell find ./project -mindepth 1 -maxdepth 1 -type d); do \
		$(call build_file_from_sample, $$dir/.env); \
	done

# Build django and vite docker containers.
.PHONY: build
build:
	sh scripts/build.sh

# Run new-settings demo
.PHONY: legacy-settings-demo
new-settings-demo: .env
	sh project/new_settings/start.sh

down:
	docker compose down