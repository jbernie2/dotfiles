.DEFAULT_GOAL := help

HOME_DIR=$(HOME)
BASH_CONFIG_DIR="$(HOME)/.bash"
BASH_COMPLETION_DIR="$(BASH_CONFIG_DIR)/bash-completion"

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: packages
packages: ## package manager installs
	./scripts/homebrew/install.sh
		./scripts/homebrew/packages.sh

.PHONY: bash
bash: ## install/reload bash config files
	./scripts/common/create_dir.sh $(BASH_CONFIG_DIR)
		./scripts/bash/copy_bash_configs.sh $(BASH_CONFIG_DIR)
		./scripts/bash/source_config_on_startup.sh $(BASH_CONFIG_DIR)
		./scripts/bash/reload_bash_configuration.sh

.PHONY: shell-greeter
shell-greeter: ## install synth-shell-greeter
	./scripts/bash/install_synth_shell_greeter.sh $(HOME_DIR) $(BASH_CONFIG_DIR)

.PHONY: shell-prompt
shell-prompt: ## install synth-shell-prompt
	./scripts/bash/install_synth_shell_prompt.sh $(HOME_DIR) $(BASH_CONFIG_DIR)

.PHONY: git
git: ## use git configuration
	cp -f ./configs/git/.gitconfig $(HOME_DIR)

.PHONY: vim
vim: ## use vim config. Installs Vundle.
	./scripts/vim/copy_vimrc.sh $(HOME_DIR)
		./scripts/vim/install_vundle.sh $(HOME_DIR)
		./scripts/vim/install_plugins.sh

.PHONY: tmux-default-shell
tmux-default-shell: ## open tmux on shell start
	cp -f ./configs/tmux/0_tmux_on_startup.sh $(BASH_CONFIG_DIR)

.PHONY: tmux
tmux: ## use tmux config.
	cp -f ./configs/tmux/.tmux.conf $(HOME)

.PHONY: tmux
additional-steps: ## manual steps to complete installs.
	./scripts/fzf/complete_install.sh
	
#.PHONY: all
all: ## install all configurations
	$(MAKE) packages
		$(MAKE) bash
		$(MAKE) git
		$(MAKE) vim
		$(MAKE) tmux
		$(MAKE) tmux-default-shell
		$(MAKE) additional-steps
