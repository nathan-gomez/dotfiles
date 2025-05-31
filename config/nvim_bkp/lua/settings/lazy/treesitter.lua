return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "TSInstallInfo", "TSInstall" },
	config = function()
		local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")

		if not status_ok then
			return
		end

		treesitter.setup({
			ensure_installed = { "javascript", "typescript", "go", "lua", "c", "vim", "tsx", "html", "css", "json" },
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				use_languagetree = true,
				additional_vim_regex_highlighting = false,
			},
			autopairs = {
				enable = true,
			},
			indent = { enable = true },
			context_commentstring = {
				enable = true,
				autocmd = false,
			},
		})
	end,
}
