CONFIG_DIR := $(HOME)/.config

cli: nvim lazydocker lazygit fish yazi wezterm
desktop: nvim lazydocker lazygit sway waybar mako fish wezterm yazi

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

mako:
	@echo "Creating symlink: $(CONFIG_DIR)/mako"
	@ln -sfn $(PWD)/config/mako $(CONFIG_DIR)/mako

fish:
	@echo "Creating symlink: $(CONFIG_DIR)/fish"
	@ln -sfn $(PWD)/config/fish $(CONFIG_DIR)/fish

rofi:
	@echo "Creating symlink: $(CONFIG_DIR)/rofi"
	@ln -sfn $(PWD)/config/rofi $(CONFIG_DIR)/rofi

wezterm:
	@echo "Creating symlink: $(CONFIG_DIR)/wezterm"
	@ln -sfn $(PWD)/config/wezterm $(CONFIG_DIR)/wezterm

ghostty:
	@echo "Creating symlink: $(CONFIG_DIR)/ghostty"
	@ln -sfn $(PWD)/config/ghostty $(CONFIG_DIR)/ghostty

yazi:
	@echo "Creating symlink: $(CONFIG_DIR)/yazi"
	@ln -sfn $(PWD)/config/yazi $(CONFIG_DIR)/yazi

