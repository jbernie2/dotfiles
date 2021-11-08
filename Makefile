.DEFAULT_GOAL := help

HOME_DIR=$(HOME)
BASH_CONFIG_DIR="$(HOME)/.bash"

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: bash
bash: ## install/reload bash config files
	./scripts/common/create_dir.sh $(BASH_CONFIG_DIR)
		./scripts/bash/copy_bash_configs.sh $(BASH_CONFIG_DIR)
		./scripts/bash/source_config_on_startup.sh $(BASH_CONFIG_DIR)
		./scripts/bash/reload_bash_configuration.sh

.PHONY: git
git: ## use git configuration
	cp -f ./configs/git/.gitconfig $(HOME)

.PHONY: vim
vim: ## use vim config. Installs Vundle if not installed
	./scripts/vim/copy_vimrc.sh $(HOME_DIR)
		./scripts/vim/install_vundle.sh $(HOME_DIR)
		./scripts/vim/install_plugins.sh

.PHONY: tmux
tmux: ## use tmux config.
	cp -f ./configs/tmux/.tmux.conf $(HOME)

	
#.PHONY: all
all: ## install all configurations
	$(MAKE) bash
		$(MAKE) git
		$(MAKE) vim
		$(MAKE) tmux

