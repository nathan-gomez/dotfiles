local bufferline = require("bufferline")
--:h bufferline-configuration for help

bufferline.setup({
	options = {
		mode = "tabs",
		separator_style = "thick",
		show_buffer_icons = true,
		always_show_bufferline = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = false,
		show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
		color_icons = true,
		diagnostics = "nvim_lsp",
		hover = {
			enabled = true,
			delay = 150,
			reveal = { "close" },
		},
		indicator = {
			icon = "▎", -- this should be omitted if indicator style is not 'icon'
			style = "icon",
		},
	},
})

vim.keymap.set("n", "<C-l>", "<CMD>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<C-h>", "<CMD>BufferLineCyclePrev<CR>")
