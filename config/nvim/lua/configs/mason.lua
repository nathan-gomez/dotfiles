local servers = {
  -- Web dev
  "biome",
  "prettier",
  "svelte",
  "ts_ls",
  "html",
  "cssls",
  "stylelint",
  "tailwindcss",

  -- Go
  "gopls",
  "gofumpt",
  "gomodifytags",
  "golangci-lint",

  -- Lua
  "stylua",
  "lua_ls",

  -- Elixir
  "elixirls",
  "lexical",

  "clangd",
  "zls",
}

local server_opts = {}

return {
  servers = servers,
  opts = server_opts,
}
