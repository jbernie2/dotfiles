.DEFAULT_GOAL := help

HOME_DIR=$(HOME)
BASH_CONFIG_DIR="$(HOME)/.bash"

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: bash-config
bash-config: ## install bash config files and reload user settings
	./scripts/create_dir.sh $(BASH_CONFIG_DIR)
		./scripts/copy_bash_configs.sh $(BASH_CONFIG_DIR)
		./scripts/source_config_on_startup.sh
		./scripts/reload_bash_configuration.sh

#.PHONY: git-autocomplete
#git-autocomplete: ## install git autocomplete
	#./scripts/create_dir.sh $(HOME_DIR) $(BASH_CONFIG_DIR)
		#./scripts/git_auto_complete.sh
	
#.PHONY: app-build
#app-build: ## Build app development Docker images
	#$(MAKE) app-build-base-image
	## build app dev image
	#docker-compose build app

