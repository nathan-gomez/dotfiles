return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"j-hui/fidget.nvim",
	},

	config = function()
		local icons = require("icons")
		local lsp_config = require("lspconfig")
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)
		require("fidget").setup({})

		mason.setup({
			ui = {
				icons = icons.mason,
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"tsserver",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					lsp_config[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["lua_ls"] = function()
					lsp_config.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
			formatting = {
				format = function(_, item)
					local itemIcons = icons.kinds
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
	end,
}
