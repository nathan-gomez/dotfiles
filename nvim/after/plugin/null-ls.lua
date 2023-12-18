local null_ls = require("null-ls")
--
local sources = {
	null_ls.builtins.code_actions.gomodifytags,
}

null_ls.setup({
	sources = sources,
	on_attach = function(client, bufnr)
		-- if client.supports_method("textDocument/formatting") then
		-- 	vim.keymap.set("n", "<Leader>fo", function()
		-- 		vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
		-- 	end, { buffer = bufnr, desc = "[lsp] format" })
		-- end

		if client.supports_method("textDocument/rangeFormatting") then
			vim.keymap.set("x", "<Leader>f", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })
		end
	end,
})
