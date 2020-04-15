.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install-software-linux
install-software-linux: ## Installs required software (uses sudo)
	sudo apt-get update || true
	sudo apt-get install -y \
		build-essential \
		gnupg2 \
		gnupg-agent \
		gnupg-curl \
		pinentry-curses \
		scdaemon \
		pcscd \
		yubikey-personalization \
		libusb-1.0-0-dev \
		hopenpgp-tools

.PHONY: install-software-osx
install-software-osx: ## Installs required software
	brew install \
		gnupg \
		yubikey-personalization

.PHONY: configure
configure: ## Configures GPG
	@echo "Killing gpg-agent..."
	@killall gpg-agent || true
	@echo "Updating ~/.gnupg configuration..."
	@./scripts/copy-dotfiles.sh
	@echo "Setting permissions..."
	@chmod 700 ~/.gnupg
	@echo "Restarting gpg-agent..."
	@./dotfiles/shellrc
	@echo ""
	@printf "\n\033[0;32mYou should set the 'default-key' field in ~/.gnupg/gpg.conf\nto your public key's fingerprint\033[0m \n"

.PHONY: restore
restore: ## Restores lastest backup of ~/.gnupg
	./scripts/restore-gnupg-from-backup.sh

.PHONY: danger-reset-gpg-applet
danger-reset-gpg-applet: ## Reset Yubikey to factory defaults
	gpg-connect-agent -r ./scripts/reset-gpg-applet
