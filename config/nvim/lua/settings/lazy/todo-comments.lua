return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local todoComments = require("todo-comments")
		local icons = require("icons")

		todoComments.setup({
			keywords = {
				FIX = { icon = icons.todoComments.Fix, color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = icons.todoComments.Todo, color = "info" },
				HACK = { icon = icons.todoComments.Hack, color = "warning" },
				WARN = { icon = icons.todoComments.Warn, color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = icons.todoComments.Perf, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = icons.todoComments.Note, color = "hint", alt = { "INFO" } },
				TEST = { icon = icons.todoComments.Test, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "NONE",
				bg = "BOLD",
			},
		})

		vim.keymap.set("n", "<leader>tt", "<Cmd>TodoTelescope<CR>")
	end,
}
