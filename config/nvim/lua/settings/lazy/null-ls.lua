return {
	"nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local null_ls = require("null-ls")

		local sources = {
			null_ls.builtins.code_actions.gomodifytags,
			null_ls.builtins.diagnostics.golangci_lint,
			null_ls.builtins.diagnostics.actionlint,
			null_ls.builtins.diagnostics.biome,
			null_ls.builtins.diagnostics.stylelint,
		}

		null_ls.setup({ sources = sources })
	end,
}
