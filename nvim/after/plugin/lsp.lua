-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local icons = require("icons")
local lsp = require("lsp-zero")
local mason = require("mason")
local builtin = require("telescope.builtin")

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"gopls",
})

lsp.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

local cmp = require("cmp")
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<Tab>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.set_preferences({
	suggest_lsp_servers = true,
	sign_icons = icons.diagnostics,
})

mason.setup({
	ui = {
		icons = icons.mason,
	},
})

lsp.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		builtin.lsp_references()
	end, opts)
end)

lsp.setup()

cmp.setup({
	formatting = {
		format = function(_, item)
			local itemIcons = require("icons").kinds
			if itemIcons[item.kind] then
				item.kind = itemIcons[item.kind] .. item.kind
			end
			return item
		end,
	},
})

vim.diagnostic.config({
	virtual_text = true,
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		show_header = false,
		focusable = false,
		border = "rounded",
		source = "if_many",
		header = "",
		prefix = " ",
		suffix = " ",
	},
})
