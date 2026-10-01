.DEFAULT_GOAL := help

HOME_DIR=$(HOME)
BASH_CONFIG_DIR="$(HOME)/.bash"
BASH_COMPLETION_DIR="$(BASH_CONFIG_DIR)/bash-completion"
KEYBOARD_LAYOUT_DIR="./keyboards"

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: packages-osx
packages-osx: ## package manager installs
	./scripts/homebrew/install.sh
	./scripts/homebrew/packages.sh

.PHONY: packages-debian
packages-debian: ## package manager installs
	./scripts/debian/packages.sh

.PHONY: bash-osx
bash-osx: ## install/reload bash config files
	./scripts/common/create_dir.sh $(BASH_CONFIG_DIR)
	./scripts/bash/copy_bash_configs.sh $(BASH_CONFIG_DIR)
	./scripts/bash/source_config_on_startup.sh $(BASH_CONFIG_DIR) ~/.bash_profile
	./scripts/bash/reload_bash_configuration.sh
	./scripts/git/auto_complete.sh $(BASH_CONFIG_DIR)

.PHONY: bash-debian
bash-debian: ## install/reload bash config files
	./scripts/common/create_dir.sh $(BASH_CONFIG_DIR)
	./scripts/bash/copy_bash_configs.sh $(BASH_CONFIG_DIR)
	./scripts/bash/source_config_on_startup.sh $(BASH_CONFIG_DIR) ~/.bashrc
	./scripts/bash/reload_bash_configuration.sh
	./scripts/git/auto_complete.sh $(BASH_CONFIG_DIR)

.PHONY: git
git: ## use git configuration
	cp -f ./configs/git/.gitconfig $(HOME_DIR)
	cp -Rf ./configs/git/.git_template $(HOME_DIR)

.PHONY: vim
vim: ## use vim config. Installs Vundle.
	./scripts/vim/copy_vimrc.sh $(HOME_DIR)
	./scripts/vim/install_git_plug.sh $(HOME_DIR)
	./scripts/vim/install_plugin_dependencies.sh
	./scripts/vim/install_plugins.sh

.PHONY: tmux-default-shell
tmux-default-shell: ## open tmux on shell start
	cp -f ./configs/tmux/0_tmux_on_startup.sh $(BASH_CONFIG_DIR)

.PHONY: tmux
tmux: ## use tmux config.
	cp -f ./configs/tmux/.tmux.conf $(HOME_DIR)

.PHONY: psql
psql: ## use psql-cli config.
	cp -f ./configs/psql/.psqlrc $(HOME_DIR)

.PHONY: iterm-profile
iterm-profile: ## iterm customizations
	cp -f ./configs/iterm/com.googlecode.iterm2.plist $(HOME_DIR)/Library/Preferences

.PHONY: ghostty
ghostty: ## ghostty customizations
	mkdir -p $(HOME_DIR)/.configs/ghostty
	cp -f ./configs/ghostty/config.ghostty $(HOME_DIR)/.configs/ghostty

.PHONY: flash-ergodox-dry-run
flash-ergodox-dry-run: ## test ergodox keymap build
	./scripts/qmk/build_keymap.sh $(KEYBOARD_LAYOUT_DIR) "ergodox_ez" "jbernie2" true

.PHONY: flash-ergodox
flash-ergodox: ## install ergodox keymap on keyboard
	./scripts/qmk/build_keymap.sh $(KEYBOARD_LAYOUT_DIR) "ergodox_ez" "jbernie2" false

.PHONY: flash-piantor-dry-run
flash-piantor-dry-run: ## test piantor keymap build
	./scripts/qmk/build_keymap.sh $(KEYBOARD_LAYOUT_DIR) "beekeeb/piantor" "jbernie2" true

.PHONY: flash-piantor
flash-piantor: ## install piantor keymap on keyboard
	./scripts/qmk/build_keymap.sh $(KEYBOARD_LAYOUT_DIR) "beekeeb/piantor" "jbernie2" false

#.PHONY: all-osx
all-osx: ## install all configurations for osx
	$(MAKE) packages-osx
	$(MAKE) bash-osx
	$(MAKE) git
	$(MAKE) vim
	$(MAKE) tmux
	$(MAKE) tmux-default-shell
	$(MAKE) psql
	$(MAKE) iterm-profile

#.PHONY: all-debian
all-debian: ## install all configurations for debian
	$(MAKE) packages-debian
	$(MAKE) bash-debian
	$(MAKE) git
	$(MAKE) vim
	$(MAKE) tmux
	$(MAKE) tmux-default-shell
	$(MAKE) psql
	$(MAKE) ghostty
