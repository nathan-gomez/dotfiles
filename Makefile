CONFIG_DIR := $(HOME)/.config

# Default target
all: nvim tmux lazydocker lazygit fish

nvim:
	@echo "Creating symlink: $(CONFIG_DIR)/nvim"
	@ln -sfn $(PWD)/config/nvim $(CONFIG_DIR)/nvim

tmux:
	@echo "Creating symlink: $(CONFIG_DIR)/tmux"
	@ln -sfn $(PWD)/config/tmux $(CONFIG_DIR)/tmux

lazydocker:
	@echo "Creating symlink: $(CONFIG_DIR)/lazydocker"
	@ln -sfn $(PWD)/config/lazydocker $(CONFIG_DIR)/lazydocker

lazygit:
	@echo "Creating symlink: $(CONFIG_DIR)/lazygit"
	@ln -sfn $(PWD)/config/lazygit $(CONFIG_DIR)/lazygit

sway:
	@echo "Creating symlink: $(CONFIG_DIR)/sway"
	@ln -sfn $(PWD)/config/sway $(CONFIG_DIR)/sway

waybar:
	@echo "Creating symlink: $(CONFIG_DIR)/waybar"
	@ln -sfn $(PWD)/config/waybar $(CONFIG_DIR)/waybar

fish:
	@echo "Creating symlink: $(CONFIG_DIR)/fish"
	@ln -sfn $(PWD)/config/fish $(CONFIG_DIR)/fish

zsh:
	@echo "Creating symlink: $(HOME)/.zshrc"
	@ln -sfn $(PWD)/.zshrc $(HOME)/.zshrc

ghostty:
	@echo "Creating symlink: $(CONFIG_DIR)/ghostty"
	@ln -sfn $(PWD)/config/ghostty $(CONFIG_DIR)/ghostty

rofi:
	@echo "Creating symlink: $(CONFIG_DIR)/rofi"
	@ln -sfn $(PWD)/config/rofi $(CONFIG_DIR)/rofi

.PHONY: all nvim tmux lazydocker lazygit zsh rofi waybar sway fish
