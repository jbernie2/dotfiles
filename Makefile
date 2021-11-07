.DEFAULT_GOAL := help

HOME_DIR=$(HOME)
BASH_CONFIG_DIR="$(HOME)/.bash"

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: bash
bash: ## install bash config files and reload user settings
	./scripts/create_dir.sh $(BASH_CONFIG_DIR)
		./scripts/copy_bash_configs.sh $(BASH_CONFIG_DIR)
		./scripts/source_config_on_startup.sh $(BASH_CONFIG_DIR)
		./scripts/reload_bash_configuration.sh

.PHONY: git
git: ## use git configuration
	cp -f ./configs/git/.gitconfig $(HOME)

#.PHONY: vim
#vim: ## use vim config. Installs Vundle if not installed
	#cp -f ./configs/git/.gitconfig $(HOME)

#.PHONY: tmux
#tmux: ## use vim config. Installs Vundle if not installed
	#cp -f ./configs/git/.gitconfig $(HOME)

	
#.PHONY: app-build
#app-build: ## Build app development Docker images
	#$(MAKE) app-build-base-image
	## build app dev image
	#docker-compose build app

