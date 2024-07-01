return {
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },

		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			local sorters = require("telescope.sorters")
			local previewers = require("telescope.previewers")

			telescope.setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"-L",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					prompt_prefix = "   ",
					selection_caret = "  ",
					entry_prefix = "  ",
					initial_mode = "insert",
					selection_strategy = "reset",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					file_sorter = sorters.get_fuzzy_file,
					file_ignore_patterns = { "node_modules" },
					generic_sorter = sorters.get_generic_fuzzy_sorter,
					path_display = { "truncate" },
					winblend = 0,
					border = {},
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
					set_env = { ["COLORTERM"] = "truecolor" },
					file_previewer = previewers.vim_buffer_cat.new,
					grep_previewer = previewers.vim_buffer_vimgrep.new,
					qflist_previewer = previewers.vim_buffer_qflist.new,
					buffer_previewer_maker = previewers.buffer_previewer_maker,
					mappings = {
						n = { ["q"] = actions.close },
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-l>"] = actions.select_default,
							["<C-s>"] = actions.cycle_previewers_next,
							["<C-a>"] = actions.cycle_previewers_prev,
							["<ESC>"] = actions.close,
						},
					},
				},

				extensions_list = { "themes", "terms", "fzf" },
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					file_browser = { hijack_netrw = true },
				},
			})

			telescope.load_extension("file_browser")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
			vim.api.nvim_set_keymap("n", "<leader>fe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {})
			vim.keymap.set("n", "<leader>pws", function()
				local word = vim.fn.expand("<cword>")
				builtin.grep_string({ search = word })
			end)
		end,
	},
}
