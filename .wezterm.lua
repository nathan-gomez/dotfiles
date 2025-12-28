local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.default_prog = { "pwsh.exe", "-NoLogo" }

config.color_scheme = "UltraDark"

config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.5,
}

config.font = wezterm.font({ family = "JetBrainsMono Nerd Font Mono", weight = "Regular" })
config.font_size = 10.0

-- Window
config.window_decorations = "RESIZE"
config.window_background_opacity = 1.0
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 0,
}

-- Tab Bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_and_split_indices_are_zero_based = false

-----------------------------------------------------
-- KEYBINDINGS
-----------------------------------------------------
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 3000 }
config.keys = {

	{
		key = ",",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-----------------------------------------------------
	-- TABS
	-----------------------------------------------------
	-- Jump to tab
	{ key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },
	{ key = "0", mods = "LEADER", action = wezterm.action.ActivateTab(9) },
	{ key = "l", mods = "LEADER", action = wezterm.action.ActivateLastTab },

	-- Tab switcher
	{ key = "w", mods = "LEADER", action = wezterm.action.ShowTabNavigator },

	{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "v", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-----------------------------------------------------
	-- PANE NAVIGATION WITH ALT
	-----------------------------------------------------
	{ key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },

	{ key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
	{ key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },

	-- Fix for Ctrl+Space in Neovim/Windows
	{
		key = " ",
		mods = "CTRL",
		action = wezterm.action.SendKey({ key = " ", mods = "CTRL" }),
	},
}

-----------------------------------------------------
-- LAUNCH PROFILES
-----------------------------------------------------
local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "pwsh.exe", "-NoLogo" },
	})
	table.insert(launch_menu, {
		label = "PowerShell (Admin)",
		args = { "pwsh.exe", "-NoLogo", "-Command", "Start-Process pwsh.exe -Verb runAs" },
	})
	table.insert(launch_menu, {
		label = "Git Bash",
		args = { "C:/Program Files/Git/bin/bash.exe" },
	})
end

config.launch_menu = launch_menu

return config
