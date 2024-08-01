CONFIG_DIR := $(HOME)/.config

# Default target
all: nvim tmux ohmyposh kitty lazydocker lazygit zsh

nvim:
	@echo "Creating symlink: $(CONFIG_DIR)/nvim"
	@ln -sfn $(PWD)/config/nvim $(CONFIG_DIR)/nvim

tmux:
	@echo "Creating symlink: $(CONFIG_DIR)/tmux"
	@ln -sfn $(PWD)/config/tmux $(CONFIG_DIR)/tmux

ohmyposh:
	@echo "Creating symlink: $(CONFIG_DIR)/ohmyposh"
	@ln -sfn $(PWD)/config/ohmyposh $(CONFIG_DIR)/ohmyposh

kitty:
	@echo "Creating symlink: $(CONFIG_DIR)/kitty"
	@ln -sfn $(PWD)/config/kitty $(CONFIG_DIR)/kitty

lazydocker:
	@echo "Creating symlink: $(CONFIG_DIR)/lazydocker"
	@ln -sfn $(PWD)/config/lazydocker $(CONFIG_DIR)/lazydocker

lazygit:
	@echo "Creating symlink: $(CONFIG_DIR)/lazygit"
	@ln -sfn $(PWD)/config/lazygit $(CONFIG_DIR)/lazygit

zsh:
	@echo "Creating symlink: $(HOME)/.zshrc"
	@ln -sfn $(PWD)/.zshrc $(HOME)/.zshrc


.PHONY: all nvim tmux ohmyposh kitty lazydocker lazygit zsh
