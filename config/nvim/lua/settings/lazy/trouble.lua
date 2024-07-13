return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local trouble = require("trouble")
		local icons = require("icons")

		trouble.setup({
			mode = "workspace_diagnostics",
			action_keys = { -- key mappings for actions in the trouble list
				close = "q", -- close the list
				cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
				refresh = "r", -- manually refresh
				jump = { "<cr>", "<tab>", "<1-leftmouse>" }, -- jump to the diagnostic or open / close folds
				open_split = { "<c-x>" }, -- open buffer in new split
				open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
				open_tab = { "<c-t>" }, -- open buffer in new tab
				jump_close = { "o" }, -- jump to the diagnostic and close the list
				toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
				switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
				toggle_preview = "P", -- toggle auto_preview
				hover = "K", -- opens a small popup with the full multiline message
				preview = "p", -- preview the diagnostic location
				open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
				close_folds = { "zF", "zf" }, -- close all folds
				open_folds = { "zO", "zo" }, -- open all folds
				toggle_fold = { "zA", "za" }, -- toggle fold of current file
				previous = "k", -- previous item
				next = "j", -- next item
				help = "?", -- help menu
			},
			include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" }, -- for the given modes, include the declaration of the current symbol in the results
			icons = {
				indent = {
					top = "│ ",
					middle = "├╴",
					last = "└╴",
					fold_open = " ",
					fold_closed = " ",
					ws = "  ",
				},
				folder_closed = icons.misc.FolderClosed,
				folder_open = icons.misc.FolderOpen,
			},
			use_diagnostic_signs = true,
		})

		vim.keymap.set("n", "<leader>xw", "<CMD>Trouble diagnostics toggle focus=true<CR>")
		vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>")
	end,
}
