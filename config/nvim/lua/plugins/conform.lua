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
      javascript = { "prettier", "biome", stop_after_first = true },
      typescript = { "prettier", "biome", stop_after_first = true },
      javascriptreact = { "biome", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettier", stop_after_first = true },
      json = { "biome", "prettier", stop_after_first = true },
      yaml = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      markdown = { "prettier" },
    },
  },
}
