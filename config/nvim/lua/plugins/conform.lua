return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  cmd = { "ConformInfo" },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "gofumpt" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      svelte = { "dprint" },
      javascript = { "dprint", "prettier", stop_after_first = true },
      typescript = { "dprint", "prettier", stop_after_first = true },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      markdown = { "prettier" },
    },
  },
}
