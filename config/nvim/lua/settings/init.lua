require("settings.remap")
require("settings.set")
require("settings.lazy_init")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local lsp_group = augroup("LSPGroup", {})
local yank_group = augroup('HighlightYank', {})

autocmd("LspAttach", {
	group = lsp_group,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<C-cr>", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() require("telescope.builtin").lsp_references() end, opts)
    vim.keymap.set("n", "<F12>", function() require("telescope.builtin").lsp_references() end, opts)
	end,
})

autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = yank_group,
	pattern = "*",
})
