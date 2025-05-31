return {
	"nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local null_ls = require("null-ls")

		local sources = {
      -- Go
			null_ls.builtins.code_actions.gomodifytags,
			null_ls.builtins.diagnostics.golangci_lint,

      -- GitHub Actions
			null_ls.builtins.diagnostics.actionlint,

      -- Web Dev
			null_ls.builtins.diagnostics.biome,
			null_ls.builtins.diagnostics.stylelint,
		}

		null_ls.setup({ sources = sources })
	end,
}
