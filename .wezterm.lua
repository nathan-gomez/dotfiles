local wezterm = require("wezterm")
local config = wezterm.config_builder()
local theme_name = "DWM rob (terminal.sexy)"
-- local theme_name = "UltraDark"
local tab_theme = "Adventure"

config.default_prog = { "pwsh.exe", "-NoLogo" }
config.color_scheme = theme_name
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.5,
}

config.font = wezterm.font({ family = "JetBrainsMono Nerd Font Mono", weight = "Regular" })
config.font_size = 12.0

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
	-- WORKSPACES
	-----------------------------------------------------
	-- Workspace switcher
	{ key = "s", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },

	{
		key = "(",
		mods = "LEADER|SHIFT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for session",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					wezterm.mux.rename_workspace(window:mux_window():get_workspace(), line)
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

	{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },

	{ key = "&", mods = "LEADER|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },

	-- Tab switcher
	{ key = "w", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|TABS" }) },

	-----------------------------------------------------
	-- PANES
	-----------------------------------------------------
	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "v", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "{", mods = "LEADER|SHIFT", action = wezterm.action.PaneSelect({ mode = "SwapWithActiveKeepFocus" }) },

	-- Navigation
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
		label = "Cmd",
		args = { "cmd.exe" },
	})
	table.insert(launch_menu, {
		label = "Git Bash",
		args = { "C:/Program Files/Git/bin/bash.exe" },
	})
end

config.launch_menu = launch_menu

-----------------------------------------------------
-- PLUGINS
-----------------------------------------------------
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local function tab_title(tab)
	local label
	if tab.tab_title and #tab.tab_title > 0 then
		label = tab.tab_title
	else
		local name = tab.active_pane and tab.active_pane.foreground_process_name or ""
		name = name:match("([^/\\]+)[/\\]?$") or name
		if name == "" or name == "wslhost.exe" then
			name = (tab.active_pane and tab.active_pane.title) or "wezterm"
		end
		label = name
	end
	return " " .. label .. " "
end

tabline.setup({
	options = {
		icons_enabled = false,
		theme = tab_theme,
		theme_overrides = {},
		section_separators = {
			left = wezterm.nerdfonts.ple_upper_left_triangle,
			right = wezterm.nerdfonts.ple_upper_right_triangle,
		},
		component_separators = {
			left = wezterm.nerdfonts.ple_upper_left_triangle,
			right = wezterm.nerdfonts.ple_upper_right_triangle,
		},
		tab_separators = {
			left = wezterm.nerdfonts.ple_upper_left_triangle,
			right = wezterm.nerdfonts.ple_lower_right_triangle,
		},
	},
	sections = {
		tabline_a = { "mode" },
		tabline_b = { "" },
		tabline_c = { "" },
		tab_active = {
			"index",
			tab_title,
			{ "zoomed", padding = 0 },
		},
		tab_inactive = {
			"index",
			tab_title,
			{ "zoomed", padding = 0 },
		},
		tabline_x = { "" },
		tabline_y = { "workspace" },
		tabline_z = { "domain" },
	},
	extensions = {},
})
tabline.apply_to_config(config)

return config
