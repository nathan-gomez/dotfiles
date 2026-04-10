local servers = {
  -- Web dev
  "ts_ls",
  "html",
  "cssls",
  "stylelint",

  -- Go
  "gopls",
  "gofumpt",
  "gomodifytags",
  "golangci-lint",

  -- Lua
  "stylua",
  "lua_ls",

  "clangd",
  "zls",
}

local server_opts = {}

return {
  servers = servers,
  opts = server_opts,
}
