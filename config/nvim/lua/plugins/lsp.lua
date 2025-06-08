return {
  "neovim/nvim-lspconfig",
  event = "User FilePost",
  lazy = false,
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    "saghen/blink.cmp",
  },
  config = function()
    local autocmd = vim.api.nvim_create_autocmd
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local lsp_configs = {
      on_attach = function(bufnr)
        local function opts(desc)
          return { buffer = bufnr, desc = "LSP " .. desc }
        end
        local map = vim.keymap.set
        local telescope = require("telescope.builtin")

        map("n", "gd", telescope.lsp_definitions, opts("Go to definition"))

        map("n", "K", vim.lsp.buf.hover, opts("Hover"))

        map("n", "<leader>vca", vim.lsp.buf.code_action, opts("Code actions"))

        map("n", "<leader>vrn", vim.lsp.buf.rename, opts("Rename"))
        map("n", "<F2>", vim.lsp.buf.rename, opts("Rename"))

        map("n", "<leader>vrr", telescope.lsp_references, opts("References"))
        map("n", "<F12>", telescope.lsp_references, opts("References"))

        map("n", "<leader>ds", telescope.lsp_document_symbols, opts("Open document symbols"))

        map("n", "]d", vim.diagnostic.goto_next, opts("Next diagnostic"))
        map("n", "[d", vim.diagnostic.goto_next, opts("Previous diagnostic"))
      end,

      on_init = function(client, _)
        if client.supports_method("textDocument/semanticTokens") then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end,

      capabilities = vim.lsp.protocol.make_client_capabilities(),
    }

    lsp_configs.capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    autocmd("LspAttach", {
      callback = function(args)
        lsp_configs.on_attach(args.buf)
      end,
    })

    -- Install defined servers
    local mason_configs = require("configs.mason")
    local ensure_installed = mason_configs.servers or {}
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    -- Enable installed servers
    require("mason-lspconfig").setup({
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = mason_configs.opts[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })

    return lsp_configs
  end,
}
