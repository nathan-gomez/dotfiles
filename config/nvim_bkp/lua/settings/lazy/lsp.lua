return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		event = { "BufReadPre", "BufNewFile" },
		cmd = "Mason",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			-- Lsp
			local lsp = require("lsp-zero").preset("recommended")
			local icons = require("icons")

			lsp.on_attach(function(_, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end)

			lsp.set_sign_icons({
				error = icons.diagnostics.Error,
				warn = icons.diagnostics.Warn,
				hint = icons.diagnostics.Hint,
				info = icons.diagnostics.Info,
			})

			lsp.setup()

			-- Cmp
			local cmp = require("cmp")
			local cmp_lsp = require("cmp_nvim_lsp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				preselect = cmp.PreselectMode.None,
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
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

      -- Luasnip keymaps
			vim.keymap.set({ "i", "s" }, "<C-l>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { desc = "Snippet next argument", silent = true })

			vim.keymap.set({ "i", "s" }, "<C-h>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { desc = "Snippet previous argument", silent = true })

			-- Mason
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local lsp_config = require("lspconfig")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			mason.setup({
				ui = {
					icons = icons.mason,
				},
			})

			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
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

			-- Diagnostic
			vim.diagnostic.config({
				virtual_text = false,
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
	},
	{
		"j-hui/fidget.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("fidget").setup({})
		end,
	},
}
