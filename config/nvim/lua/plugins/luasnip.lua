return {
  "L3MON4D3/LuaSnip",
  version = "2.*",
  event = "BufReadPre",
  build = "make install_jsregexp CC=zig cc",
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  config = function()
    require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets/" })

    local ls = require("luasnip")
    ls.setup({
      update_events = { "TextChanged", "TextChangedI" },
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
    })

    vim.keymap.set({ "i", "s" }, "<C-l>", function() ls.jump(1) end, { silent = true, desc = "next autocomplete" })
    vim.keymap.set({ "i", "s" }, "<C-h>", function() ls.jump(-1) end, { silent = true, desc = "previous autocomplete" })
  end,
}
